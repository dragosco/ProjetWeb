package servlets;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireEcoles;
import gestionnaires.GestionnaireUtilisateurs;
import java.util.Collection;
import javax.ejb.EJB;
import java.io.IOException;
import java.util.Calendar;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
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
import modeles.Photo;
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
        
        Collection<Annonce> annonces = null;
        long total = 0;
        
        Collection<Categorie> categories = gc.getCategories();
        request.setAttribute("categories", categories);
        
        Collection<Ecole> ecoles = ge.getEcoles();
        request.setAttribute("ecoles", ecoles);
        
        String action = request.getParameter("action");
        
        if(action != null) {
            if(action.equals("filtrerVentes")) {
                total = ga.getCountAnnonces(
                    request.getParameter("motscles"),
                    request.getParameter("categorie"),
                    request.getParameter("ecole"),
                    request.getParameter("etudiant"),
                    request.getParameter("prix"),
                    0 //Integer.parseInt(request.getParameter("annonceType"))
                );                
                annonces = ga.getAnnonces(
                        request.getParameter("motscles"),
                        request.getParameter("categorie"),
                        request.getParameter("ecole"),
                        request.getParameter("etudiant"),
                        request.getParameter("prix"),
                        0, //Integer.parseInt(request.getParameter("annonceType")),
                        request.getParameter("debut"),
                        request.getParameter("nombreParPage")
                    );
                completeRequest(annonces, total, 0, request, response);
            } else if (action.equals("supprimerAnnonce")) {
                int id = Integer.parseInt(request.getParameter("id"));
                //L'admin peut supprimer n'importe quelle annonce. Un user ne peut supprimer que les siens.
                if (u.getPrivilege().equals("admin") || ga.getAnnonce(id).getAuteur().equals(u)){
                    ga.supprimerAnnonce(id);
                } else {
                    //ne rien faire
                }
                
                total = ga.getCountAnnonces();
                annonces = ga.getAnnonces();
                completeRequest(annonces, total, 0, request, response);
            } else {
                System.out.println("listerVentes");
                System.out.println("debut : " + request.getParameter("debut"));
                if(!request.getParameter("debut").isEmpty()) {
                    int start = Integer.parseInt(request.getParameter("debut"));
                    int nParPage = Integer.parseInt(request.getParameter("nombreParPage"));
                    if (start >= 0) {
                        response.setContentType("application/json");
                        if(action.equals("listerVentes")) {
                            response.getWriter().write(
                                    listerVentes
                                    (
                                        request.getParameter("motscles"),
                                        request.getParameter("categorie"),
                                        request.getParameter("ecole"),
                                        request.getParameter("etudiant"),
                                        request.getParameter("prix"),
                                        0,
                                        request.getParameter("debut"),
                                        request.getParameter("nombreParPage")
                                    ).toString()
                                );
                        }
                    }
                }                    
            }
        } else {
            total = ga.getCountAnnonces();
            annonces = ga.getAnnonces();
            completeRequest(annonces, total, 0, request, response);
        }
        
        //System.out.println("annonces : " + annonces.size());
        

    }
    
    public void completeRequest(Collection<Annonce> annonces, long total, int annonceType, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        request.setAttribute("annonces", annonces);
        request.setAttribute("total", total);
        
        Double minPrix = ga.getMinPrix(annonceType);
        Double maxPrix = ga.getMaxPrix(annonceType);
        
        request.setAttribute("minPrix", minPrix);
        request.setAttribute("maxPrix", maxPrix);
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(request, response);
    }
    
    public JsonArray listerVentes(String motscles, String categorie, String ecole, String etudiant, String prix, int annonceType, String debut, String nombreParPage) {
        System.out.println("entra listerventes servlet");
        
        Collection<Annonce> annonces = ga.getAnnonces(motscles, categorie, ecole, etudiant, prix, annonceType, debut, nombreParPage);
        System.out.println("qdt annonces : " + annonces.size());
        long total = ga.getCountAnnonces(motscles, categorie, ecole, etudiant, prix, annonceType); 
        
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        jsonArrayBuilder.add(Json.createObjectBuilder().add("total", total));
        
        for(Annonce a: annonces) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(a.getDateDepot());
            int date = cal.get(Calendar.DATE);
            int mois = cal.get(Calendar.MONTH);
            int heure = cal.get(Calendar.HOUR);
            int min = cal.get(Calendar.MINUTE);
            
            jsonArrayBuilder.add(
                    Json.createObjectBuilder()
                            .add("id", a.getId())
                            .add("type", a.getType())
                            .add("titre", a.getTitre())
                            .add("categorie", a.getCategorie().getNom())
                            .add("prix", a.getPrix())
                            .add("description", a.getDescription())
                            .add("pseudo", a.getAuteur().getPseudo())
                            //.add("photos", a.getPhotos())
                            .add("dateDepot", a.getDateDepot().toString())
                            .add("idPhoto", (a.getPhotos() != null && !a.getPhotos().isEmpty()) ? ((Photo)a.getPhotos().toArray()[0]).getId() : 0) //a.getPhotos().toArray()[0].getId())
                            .add("qdtPhotos", a.getPhotos().size())
                            .add("photoAuteur", a.getAuteur().getPhoto() != null ? "photo" : "")
                            .add("idAuteur", a.getAuteur().getId())
                            .add("dateFin", a.getDateFin() != null ? a.getDateFin().toString() : "")
                            .add("dateDepotDate", date + "/" + mois)
                            .add("dateDepotHeure", heure + "h" + min)
                            //.add("auteur", a.getAuteur())
            );
        }
              
        JsonArray jsonArray = jsonArrayBuilder.build();
        System.out.println("json : " + jsonArray.toString());
        
        return jsonArray;
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
