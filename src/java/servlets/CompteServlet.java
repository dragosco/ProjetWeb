/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import gestionnaires.GestionnaireEcoles;
import gestionnaires.GestionnaireUtilisateurs;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import javax.ejb.EJB;
import javax.imageio.ImageIO;
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
                //On récupère la part correspondant à la photo
                Part profilePic = request.getPart("profilePic");
                //On la transforme en InputStream
                InputStream contenuImage = profilePic.getInputStream();
                //On transforme le flux d'octets en BufferedImage
                BufferedImage imgOrig = ImageIO.read(contenuImage);
                
                //Le preview de l'image a un Width égale à 'ratioDivider'
                //On divise le Width de l'image originale par ce 'ratioDivider' afin d'obtenir le ratio
                double ratioDivider = Double.parseDouble(request.getParameter("ratiodivider"));
                double imgWidth = imgOrig.getWidth();
                double ratio = Math.floor(imgWidth/ratioDivider);
                
                int x = (int) (ratio * Double.parseDouble(request.getParameter("x")));
                int y = (int) (ratio * Double.parseDouble(request.getParameter("y")));
                int width;
                if (imgOrig.getWidth() > x + (int) (ratio * Double.parseDouble(request.getParameter("w")))) {
                    width = (int) (ratio * Double.parseDouble(request.getParameter("w")));
                } else {
                    width = imgOrig.getWidth() - x;
                }
                int height;
                if (imgOrig.getHeight() > y + (int) (ratio * Double.parseDouble(request.getParameter("h")))) {
                    height = (int) (ratio * Double.parseDouble(request.getParameter("h")));
                } else {
                    height = imgOrig.getHeight() - y;
                }
                
                //On découpe l'image en fonction des coordonnées grâce à la requête et en multipliant par le ratio
                BufferedImage imgCropped = imgOrig.getSubimage(x, y, width, height);
                
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
                        BufferedImageToByteArray(imgCropped)
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
                BufferedImage imgOrig = ImageIO.read(nouvContenuImage);
                double ratioDivider = Double.parseDouble(request.getParameter("ratiodivider"));
                double imgWidth = imgOrig.getWidth();
                double ratio = imgWidth/ratioDivider;
                
                int x = (int) (ratio * Double.parseDouble(request.getParameter("x")));
                int y = (int) (ratio * Double.parseDouble(request.getParameter("y")));
                int width;
                if (imgOrig.getWidth() > x + (int) (ratio * Double.parseDouble(request.getParameter("w")))) {
                    width = (int) (ratio * Double.parseDouble(request.getParameter("w")));
                } else {
                    width = imgOrig.getWidth() - x;
                }
                int height;
                if (imgOrig.getHeight() > y + (int) (ratio * Double.parseDouble(request.getParameter("h")))) {
                    height = (int) (ratio * Double.parseDouble(request.getParameter("h")));
                } else {
                    height = imgOrig.getHeight() - y;
                }
                
                BufferedImage imgCropped = imgOrig.getSubimage(x, y, width, height);
                
                gu.changePhoto(user, BufferedImageToByteArray(imgCropped));
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

    public byte[] BufferedImageToByteArray(BufferedImage bi) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write( bi, "jpg", baos );
        baos.flush();
        byte[] imageInBytes = baos.toByteArray();
        baos.close();
        return imageInBytes;
    }
}
