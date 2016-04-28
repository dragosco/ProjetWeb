/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireEcoles;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
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
import modeles.Ecole;
import outils.InputStreamToByteArray;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Compte", urlPatterns = {"/Compte"})
@MultipartConfig
public class CompteServlet extends HttpServlet {
    @EJB
    private GestionnaireUtilisateurs gu;
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
        String pseudo = request.getParameter("pseudo");
        if(pseudo != null) {
            response.setContentType("application/json");
            response.getWriter().write(generateJSON(pseudo).toString());
        } else {
            Collection<Ecole> allEcoles = ge.getEcoles();
            request.setAttribute("allEcoles", allEcoles);
            
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("nouveauCompte.jsp") ;
            requestDispatcher.include(request, response) ;
        }
    }

    public JsonObject generateJSON(String pseudo) {
        JsonObject jsonData; 
        if(gu.getUtilisateur(pseudo) == null) {
            jsonData = Json.createObjectBuilder()
                    .add("existe", "false")
                    .build();
        } else {
            jsonData = Json.createObjectBuilder()
                    .add("existe", "true")
                    .build();
        }
        return jsonData;
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
        String message = "";
        if(action != null) {
            if(action.equals("creerNouveauCompte")) {
                Part profilePic = request.getPart("profilePic");
                InputStream contenuImage = profilePic.getInputStream();
                InputStreamToByteArray ISBA = new InputStreamToByteArray(contenuImage);
        
                if(gu.getUtilisateur(request.getParameter("pseudo")) == null) {
                    gu.creerUtilisateur(
                        request.getParameter("nom"), 
                        request.getParameter("prenom"), 
                        request.getParameter("pseudo"), 
                        request.getParameter("motDePasse"), 
                        request.getParameter("ecole"), 
                        request.getParameter("mail"), 
                        request.getParameter("tel"),
                        "user",
                        ISBA.getBytes()
                    );
                    message = "compteOK";
                    response.sendRedirect("Accueil?message=" + message);
                } else {
                    
                }
            /*  
                La servlet 'Compte' gère aussi le changement de photo de profil de l'utilisateur.
                Cette implémentation a été nécessaire car l'upload de la nouvelle photo nécessite
                que la servlet soit @MultipartConfig.
            */
            } else if(action.equals("changePhoto")) {
                HttpSession session = request.getSession();
                String user = (String) session.getAttribute("USER");
                Part nouvProfilePic = request.getPart("nouvProfilePic");
                InputStream nouvContenuImage = nouvProfilePic.getInputStream();
                InputStreamToByteArray nouvISBA = new InputStreamToByteArray(nouvContenuImage);
                gu.changePhoto(user, nouvISBA.getBytes());
                response.sendRedirect("Profil?user=" + user);
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
