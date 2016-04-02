/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
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
    private GestionnaireAnnonces go;
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnairePhotos gp;
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
            
            
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
            requestDispatcher.include(request, response);
        } else {
            
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
            if(action != null) {
                if(action.equals("creerCategorie")) {
                    gc.creerCategorie(request.getParameter("titre"));
                    
                } else if(action.equals("supprimerCategorie")) {
                    gc.supprimerCategorie(request.getParameter("titre"));
                }
                response.sendRedirect("Admin");
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
