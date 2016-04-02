/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireUtilisateurs;
import java.util.Collection;
import javax.ejb.EJB;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modeles.Annonce;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Accueil", urlPatterns = {"/Accueil"})
public class AccueilServlet extends HttpServlet {
    @EJB
    private GestionnaireAnnonces ga;
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
        HttpSession session = request.getSession();
        Utilisateur u = (Utilisateur) session.getAttribute("PROFIL");
        
        Collection<Annonce> annonces = ga.getAnnonces();
        request.setAttribute("annonces", annonces);
        request.setAttribute("nAnnonces", 2);
        
        String action = request.getParameter("action");
        if(action != null) {
            
            if (action.equals("supprimerAnnonce")) {
                int id = Integer.parseInt(request.getParameter("id"));
                //L'admin peut supprimer n'importe quelle annonce. Un user ne peut supprimer que les siens.
                if (u.getPrivilege().equals("admin") || ga.getAnnonce(id).getAuteur().equals(u)){
                    ga.supprimerAnnonce(id);
                } else {
                    //ne rien faire
                }
            }
        }
        
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(request, response);
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
        String action = "";
        
        
        
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
