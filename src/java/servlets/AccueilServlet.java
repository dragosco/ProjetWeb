package servlets;
import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireEcoles;
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
import modeles.Categorie;
import modeles.Ecole;
import modeles.Utilisateur;

/**
 * @authors Dragos, Thais
 */
@WebServlet(name = "Accueil", urlPatterns = {"/Accueil"})
public class AccueilServlet extends HttpServlet {
    @EJB
    private GestionnaireEcoles ge;
    @EJB
    private GestionnaireAnnonces ga;
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnaireCategories gc;

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
        
        Collection<Annonce> annonces;
        
        Collection<Categorie> categories = gc.getCategories();
        request.setAttribute("categories", categories);
        
        Collection<Ecole> ecoles = ge.getEcoles();
        request.setAttribute("ecoles", ecoles);
        
        String action = request.getParameter("action");
        
        if(action != null) {
            if(action.equals("filtrerAnnonces")) {
                annonces = ga.getAnnonces(request.getParameter("motscles"),
                            request.getParameter("categorie"),
                            request.getParameter("ecole"),
                            request.getParameter("etudiant"),
                            request.getParameter("prix"),
                            request.getParameter("annonceType"));

                request.setAttribute("annonces", annonces);
            } else if (action.equals("supprimerAnnonce")) {
                int id = Integer.parseInt(request.getParameter("id"));
                //L'admin peut supprimer n'importe quelle annonce. Un user ne peut supprimer que les siens.
                if (u.getPrivilege().equals("admin") || ga.getAnnonce(id).getAuteur().equals(u)){
                    ga.supprimerAnnonce(id);
                } else {
                    //ne rien faire
                }
                
                annonces = ga.getAnnonces();
                request.setAttribute("annonces", annonces);
            } 
        } else {
            annonces = ga.getAnnonces();
            request.setAttribute("annonces", annonces);
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
        
    }

}
