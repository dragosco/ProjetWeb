/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireOffres;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Dragos
 */
@WebServlet(name = "Annonce", urlPatterns = {"/Annonce"})
@MultipartConfig //Annotation nécessaire pour les servlets manipulant des BLOB
public class AnnonceServlet extends HttpServlet {
    @EJB
    private GestionnaireOffres go;
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
        //à compléter
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
        
        Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
        String nomImage = filePart.getSubmittedFileName();
        InputStream contenuImage = filePart.getInputStream();
        String action = request.getParameter("action");
        
        if(action != null) {
            if (action.equals("creerOffre")) {
                    go.creerOffre(
                            request.getParameter("titre"),
                            request.getParameter("categorie"),
                            Double.parseDouble(request.getParameter("prix")),
                            request.getParameter("description"),
                            getBytes(contenuImage),
                            null,
                            null
                    );
                    response.sendRedirect("depotAnnonce.jsp");
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

    public static byte[] getBytes(InputStream is) throws IOException {

        int len;
        int size = 1024*16;
        byte[] buf;

        if (is instanceof ByteArrayInputStream) {
          size = is.available();
          buf = new byte[size];
          len = is.read(buf, 0, size);
        } else {
          ByteArrayOutputStream bos = new ByteArrayOutputStream();
          buf = new byte[size];
          while ((len = is.read(buf, 0, size)) != -1)
            bos.write(buf, 0, len);
          buf = bos.toByteArray();
        }
        return buf;
  }
}
