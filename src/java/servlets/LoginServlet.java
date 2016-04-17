/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireUtilisateurs;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.ejb.EJB;
import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {
    @EJB
    private GestionnaireUtilisateurs gu;

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
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp") ;
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
        
        if (action != null) {
            
            if (action.equals("authentification")) {
                HttpSession session = request.getSession();
                String pseudo = request.getParameter("pseudo");
                String motDePasse = request.getParameter("motDePasse");
                
                if (gu.verifierAuthentification(pseudo, motDePasse)) {
                    Utilisateur profil = gu.getUtilisateur(pseudo);
                    session.setAttribute("PROFIL", profil);
                    session.setAttribute("USER", pseudo);
                    if (profil.getPrivilege().equals("admin")) {
                        session.setAttribute("PRIVILEGE", "admin"); 
                    } else {
                        session.setAttribute("PRIVILEGE", "user"); 
                    }
                    response.sendRedirect("Accueil");
                    
                } else {
                    response.sendRedirect("Compte?message=loginKO");
                }
                
            } else if (action.equals("motDePassOublie")) {
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
