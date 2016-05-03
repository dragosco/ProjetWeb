/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireEcoles;
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
import modeles.Annonce;
import modeles.Ecole;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Profil", urlPatterns = {"/Profil"})
public class ProfilServlet extends HttpServlet {
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnaireAnnonces ga;
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
        String pseudo = request.getParameter("user");
        String forwardTo = "";
        
        Collection<Ecole> allEcoles = ge.getEcoles();
        request.setAttribute("allEcoles", allEcoles);
            
        if (pseudo != null) {
            Utilisateur user = gu.getUtilisateur(pseudo);
            Collection<Annonce> sesAnnonces = ga.getAnnoncesDe(user);
            request.setAttribute("profil", user);
            request.setAttribute("sesAnnonces", sesAnnonces);
            forwardTo = "profil.jsp?user=" + pseudo;
            
            String voir = request.getParameter("voir");
            if(voir != null) {
                if (voir.equals("annonces")) {
                    forwardTo += "&voir=annonces";
                }
            }
        }
        
            
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo) ;
        requestDispatcher.include(request, response) ;
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
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("USER");
        String redirection = "";
        
        if (action != null) {
            switch(action) {
                case "changeMotDePasse" : 
                    gu.changeMotDePasse(user, request.getParameter("motDePasse"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "changeNom" : 
                    gu.changeNom(user, request.getParameter("nom"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "changePrenom" :
                    gu.changePrenom(user, request.getParameter("prenom"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "changeEcole" :
                    gu.changeEcole(user, request.getParameter("ecole"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "changeMail" :
                    gu.changeMail(user, request.getParameter("mail"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "changeTel" :
                    gu.changeTel(user, request.getParameter("tel"));
                    session.setAttribute("PROFIL", gu.getUtilisateur(user));
                    response.sendRedirect("Profil?user=" + user);
                    break;
                case "supprimerCompte" :
                    gu.supprimerUtilisateur(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("Logout");
                    break;
                case "supprimerAnnonce" :
                    ga.supprimerAnnonce(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("Profil?user=" + user + "&voir=annonces");
                    break;
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
