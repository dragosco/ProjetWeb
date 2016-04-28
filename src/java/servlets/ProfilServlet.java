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
            
            String action = request.getParameter("action");
            if(action != null) {
                if (action.equals("afficheAnnonces")) {
                    forwardTo += "&action=afficheAnnonces";
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
            response.sendRedirect("Profil?user=" + user);
            
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
