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
import java.util.ArrayList;
import java.util.Collection;
import javax.ejb.EJB;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
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
            request.setAttribute("totalUsers", allUsers.size());
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
                    
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
                    requestDispatcher.include(request, response);
                }
                int start = Integer.parseInt(request.getParameter("start"));
                int nParPage = Integer.parseInt(request.getParameter("nParPage"));
                if (start >= 0) {
                    response.setContentType("application/json");
                    if(action.equals("listerUtilisateurs")) {
                        response.getWriter().write(listeUtilisateurs(start, nParPage).toString());
                    } else if (action.equals("listerPhotos")) {
                        response.getWriter().write(listePhotos(start, nParPage).toString());
                    } else if (action.equals("listerUtilisateursAvecPhotoProfil")) {
                        response.getWriter().write(listeUtilisateursAvecPhotoProfil(start, nParPage).toString());
                    }
                    
                } else {
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
                    requestDispatcher.include(request, response);
                }
            } else {
                RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
                requestDispatcher.include(request, response);
            }
            
        }
    }

    public JsonArray listeUtilisateurs(int start, int nParPage) {
        Collection<Utilisateur> allUsers = gu.getUtilisateurs(start, nParPage);
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for(Utilisateur u: allUsers) {
            jsonArrayBuilder.add(
                    Json.createObjectBuilder()
                            .add("id", u.getId())
                            .add("nom", u.getNom() != null ? u.getNom() : "")
                            .add("prenom", u.getPrenom() != null ? u.getPrenom() : "")
                            .add("pseudo", u.getPseudo())
                            .add("ecole", u.getEcole().getNom())
                            .add("tel", u.getTel() != null ? u.getTel() : "")
                            .add("mail", u.getMail() != null ? u.getMail() : "")
                            .add("privilege", u.getPrivilege())
                            .add("photo", (u.getPhoto() != null))
            );
        }
        
        JsonArray jsonArray = jsonArrayBuilder.build();
        return jsonArray;
    }
    
    public JsonArray listePhotos(int start, int nParPage) {
        Collection<Photo> allPhotos = gp.getPhotos(start, nParPage);
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for(Photo p: allPhotos) {
            jsonArrayBuilder.add(
                    Json.createObjectBuilder()
                            .add("id", p.getId())
            );
        }

        JsonArray jsonArray = jsonArrayBuilder.build();
        return jsonArray;
    }
    
    public JsonArray listeUtilisateursAvecPhotoProfil(int start, int nParPage) {
        Collection<Utilisateur> allUsers = gu.getUtilisateurs(start, nParPage);
        Collection<Utilisateur> usersAvecPhoto = new ArrayList<Utilisateur>();
        for(Utilisateur u : allUsers) {
            if(u.getPhoto() != null) {
                usersAvecPhoto.add(u);
            }
        }
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for(Utilisateur u: usersAvecPhoto) {
            jsonArrayBuilder.add(
                    Json.createObjectBuilder()
                            .add("id", u.getId())
            );
        }

        JsonArray jsonArray = jsonArrayBuilder.build();
        return jsonArray;
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
                    gu.supprimerUtilisateur(Integer.parseInt(request.getParameter("id")));
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
