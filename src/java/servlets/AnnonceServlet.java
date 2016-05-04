/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modeles.Annonce;
import modeles.Categorie;
import modeles.Utilisateur;
import outils.InputStreamToByteArray;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Annonce", urlPatterns = {"/Annonce"})
@MultipartConfig //Annotation nécessaire pour les servlets manipulant des BLOB
public class AnnonceServlet extends HttpServlet {
    @EJB
    private GestionnaireCategories gc;
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
        
        
        String forwardTo = "";
        Collection<Categorie> categories = gc.getCategories();
        request.setAttribute("categories", categories);

        if(request.getParameter("id") != null) {
            String id = request.getParameter("id");
            Annonce annonce = ga.getAnnonce(Integer.parseInt(id));
            request.setAttribute("annonce", annonce);
            forwardTo = "detailsAnnonce.jsp?id=" + id;

        } else {
            if (session.getAttribute("USER") != null) { //si on est connecté
                forwardTo = "depotAnnonce.jsp";
            } else {
                response.sendRedirect("Accueil?message=echecDepotAnnonce");
            }
        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(forwardTo);
        requestDispatcher.include(request, response);
        
        
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
        
        Collection<byte[]> images = new ArrayList<byte[]>();
        Collection<Part> parts = request.getParts();
        for (Part p : parts) {
            if(p.getContentType() != null) {
                InputStreamToByteArray fba = 
                        new InputStreamToByteArray(p.getInputStream());
                images.add(fba.getBytes());
            }
            
        }
        
        String action = request.getParameter("action");
        if(action != null) {
            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("USER");
            Utilisateur u = (Utilisateur) session.getAttribute("PROFIL");
            
            if (action.equals("creerAnnonce")) {
                Date dateFin;
                try {
                    dateFin = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateFin"));
		//System.out.println("dateFin " + request.getParameter("dateFin"));
                } catch (ParseException e) {
                    dateFin = null;
                }
                ga.creerAnnonce(
                    request.getParameter("titre"),
                    Integer.parseInt(request.getParameter("type")),
                    Integer.parseInt(request.getParameter("categorie")),
                    Double.parseDouble(request.getParameter("prix")),
                    request.getParameter("description"),
                    dateFin,
                    user,
                    !images.isEmpty() ? images : null
                );
                
                if(Integer.parseInt(request.getParameter("type")) == 0) {
                    response.sendRedirect("Accueil");
                } else {
                    response.sendRedirect("Recherche");
                }
                
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
