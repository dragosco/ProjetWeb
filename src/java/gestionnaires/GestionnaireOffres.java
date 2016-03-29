/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import java.util.Collection;
import java.util.Date;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;
import modeles.Offre;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@Stateless
public class GestionnaireOffres {
    @EJB
    private GestionnaireUtilisateurs gu;

    @PersistenceContext
    private EntityManager em;
    
    public void creerOffresDeTest(HttpSession session) {
        String auteur = (String) session.getAttribute("USER");
        for (int i = 0; i < 10; i++) {
            creerOffre("titre"+i, "categorie"+i, (double) i, "description"+i, null, new Date(), auteur);
        }
    }

    public Offre creerOffre(String titre, String categorie, double prix, String description, byte[] img, Date dateFin, String auteur) {
        Utilisateur user = gu.getUtilisateur(auteur);
        Offre o = new Offre(titre, categorie, prix, description, img, dateFin, user);
        em.persist(o);
        return o;
       
    }

    public Collection<Offre> getOffres() {
        // Exécution d'une requête équivalente à un select *
        Query q = em.createQuery("select o from OffreOMBid o");
        return q.getResultList();
    }
}
