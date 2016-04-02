/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import static java.lang.System.gc;
import java.util.Collection;
import java.util.Date;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import modeles.Annonce;
import modeles.Categorie;
import modeles.Photo;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@Stateless
public class GestionnaireAnnonces {
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnaireCategories gc;
    
    @PersistenceContext
    private EntityManager em;
    

    public Annonce creerAnnonce(String titre, String categorie, double prix, String description, Date dateFin, String auteur, byte[] photo) {
        Utilisateur user = gu.getUtilisateur(auteur);
        Categorie categ = gc.getCategorie(categorie);
        Annonce a = new Annonce(titre, categ, prix, description, dateFin, user);
        if (photo != null) {
            Photo p = new Photo(photo);
            p.setAnnonce(a);
            em.persist(p);
            a.addPhoto(p);
        }
        em.persist(a);
        return a;
       
    }

    public Collection<Annonce> getAnnonces() {
        // Exécution d'une requête équivalente à un select *
        Query q = em.createQuery("select a from Annonce a");
        return q.getResultList();
    }
    
    public Collection<Annonce> getAnnoncesDe(Utilisateur auteur) {
        // Exécution d'une requête équivalente à un select *
        Query q = em.createQuery("select a from Annonce a where a.auteur = :auteur");
        q.setParameter("auteur", auteur);
        return q.getResultList();
    }
    
    public Annonce getAnnonce(int id) {
        try{
            Query q = em.createQuery("select a from Annonce a where a.id = :id");
            q.setParameter("id", id);
            return (Annonce) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    
    public void supprimerAnnonce(int id) {
        Query q = em.createQuery("delete from Annonce a where a.id = :id");
        q.setParameter("id", id);
        q.executeUpdate();
    }
    
    public void ajouterPhoto(int idAnnonce, byte[] photo) {
        if(photo != null) {
            Annonce a = getAnnonce(idAnnonce);
            Photo p = new Photo(photo);
            p.setAnnonce(a);
            em.persist(p);
            a.addPhoto(p);
        }
    }
    
}
