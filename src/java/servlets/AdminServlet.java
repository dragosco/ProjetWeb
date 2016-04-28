/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireEcoles;
import gestionnaires.GestionnairePhotos;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.IOException;
import java.util.Collection;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modeles.Categorie;
import modeles.Ecole;
import modeles.Photo;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Admin", urlPatterns = {"/Admin"})
public class AdminServlet extends HttpServlet {
    @EJB
    private GestionnaireCategories gc;
    @EJB
    private GestionnaireAnnonces ga;
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnairePhotos gp;
    @EJB
    private GestionnaireEcoles ge;
    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String privilege = (String) session.getAttribute("PRIVILEGE");
        
        if(privilege.equals("admin")) {
            String forwardTo = "admin.jsp";
            
            Collection<Utilisateur> allUsers = gu.getUtilisateurs();
            request.setAttribute("allUsers", allUsers);
            
            Collection<Categorie> allCategories = gc.getCategories();
            request.setAttribute("allCategories", allCategories);
            
            Collection<Photo> allPhotos = gp.getPhotos();
            request.setAttribute("allPhotos", allPhotos);
            
            Collection<Ecole> allEcoles = ge.getEcoles();
            request.setAttribute("allEcoles", allEcoles);
            
            String action = request.getParameter("action");
            if(action != null) {
                if(action.equals("filtrerUtilisateurs")) {
                    allUsers = gu.filtre(
                            request.getParameter("pseudo"),
                            request.getParameter("nom"),
                            request.getParameter("ecole")
                    );
                    request.setAttribute("allUsers", allUsers);
                }
            }
            
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
            requestDispatcher.include(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String redirection = "Admin";
        if(action != null) {
            switch(action) {
                case "supprimerUtilisateur" : 
                    gu.supprimerUtilisateur(request.getParameter("pseudo"));
                    break;
                case "changePrivilege" : 
                    gu.changePrivilege(request.getParameter("pseudo"), request.getParameter("privilege"));
                    break;
                case "supprimerPhoto" :
                    gp.supprimerPhoto(Integer.parseInt(request.getParameter("id")));
                    break;
                case "creerCategorie" :
                    gc.creerCategorie(request.getParameter("titre"));
                    break;
                case "supprimerCategorie" :
                    gc.supprimerCategorie(Integer.parseInt(request.getParameter("id")));
                    break;
                case "supprimerAnnonce" :
                    HttpSession session = request.getSession();
                    String user = (String) session.getAttribute("USER");
                    Utilisateur u = (Utilisateur) session.getAttribute("PROFIL");
                    int id = Integer.parseInt(request.getParameter("id"));
                    //L'admin peut supprimer n'importe quelle annonce. Un user ne peut supprimer que les siens.
                    if (u.getPrivilege().equals("admin") || ga.getAnnonce(id).getAuteur().equals(u)){
                        ga.supprimerAnnonce(id);
                    }
                    redirection = "Accueil";
                    break;
            }
            response.sendRedirect(redirection);
        }
    }
    
}
