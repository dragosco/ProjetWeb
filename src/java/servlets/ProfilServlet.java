/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireUtilisateurs;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Profil", urlPatterns = {"/Profil"})
public class ProfilServlet extends HttpServlet {
    @EJB
    private GestionnaireUtilisateurs gu;
    
    
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("profil.jsp") ;
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
        
        if (action != null) {
            if (action.equals("changeMotDePasse")) {
                gu.changeMotDePasse(user, request.getParameter("motDePasse"));
            } else if (action.equals("changeNom")) {
                gu.changeNom(user, request.getParameter("nom"));
            } else if (action.equals("changePrenom")) {
                gu.changePrenom(user, request.getParameter("prenom"));
            } else if (action.equals("changeEcole")) {
                gu.changeEcole(user, request.getParameter("ecole"));
            } else if (action.equals("changeMail")) {
                gu.changeMail(user, request.getParameter("mail"));
            } else if (action.equals("changeTel")) {
                gu.changeTel(user, request.getParameter("tel"));
            }
            Utilisateur profilActu = gu.getUtilisateur(user);
            session.setAttribute("PROFIL", profilActu);
            response.sendRedirect("profil.jsp");
            
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
    }// </editor-fold>

}
