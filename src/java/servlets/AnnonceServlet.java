/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import static java.lang.System.gc;
import java.util.Collection;
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
    private GestionnaireAnnonces go;
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
        Collection<Categorie> categories = gc.getCategories();
        request.setAttribute("categories", categories);
        
        String forwardTo = "";
        
        if(request.getParameter("id") != null) {
            String id = request.getParameter("id");
            Annonce annonce = go.getAnnonce(Integer.parseInt(id));
            request.setAttribute("offre", annonce);
            forwardTo = "detailsAnnonce.jsp?id=" + id;
            
        } else {
            forwardTo = "depotAnnonce.jsp";
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
        
        Part filePart = request.getPart("files[]"); // Retrieves <input type="file" name="file">
        String nomImage = filePart.getSubmittedFileName();
        InputStream contenuImage = filePart.getInputStream();
        String action = request.getParameter("action");
        
        
        
        if(action != null) {
            if (action.equals("creerAnnonce")) {
                HttpSession session = request.getSession();
                String user = (String) session.getAttribute("USER");
                go.creerAnnonce(
                        request.getParameter("titre"),
                        request.getParameter("categorie"),
                        Double.parseDouble(request.getParameter("prix")),
                        request.getParameter("description"),
                        null,
                        user,
                        getBytes(contenuImage)
                );
                response.sendRedirect("Annonce");
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
