/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnairePhotos;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modeles.Photo;

/**
 *
 * @author thais
 */
@WebServlet(name = "Image", urlPatterns = {"/Image/*"})
public class ImageServlet extends HttpServlet {
    @EJB
    private GestionnaireUtilisateurs gestionnaireUtilisateurs;
    @EJB
    private GestionnairePhotos gestionnairePhotos;
    

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
        String path = request.getPathInfo().substring(1);
        //System.out.println("path " + path);
        
        String[] parts = path.split("/");
        String action = parts[0];
        //System.out.println("action " + action);
        String imageId = parts[1];
        //System.out.println("imageId " + imageId);
        
        byte[] content = null;
        
        if(action.equals("auteur")) {
            content = gestionnaireUtilisateurs.getUtilisateur(Integer.parseInt(imageId)).getPhoto();
        } else if(action.equals("produit")) {
            Photo photo = gestionnairePhotos.getPhoto(Integer.parseInt(imageId));
            content = photo.getPhoto();
        }
        
        response.setContentType(getServletContext().getMimeType(imageId));
        response.setContentLength(content.length);
        response.getOutputStream().write(content);
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
