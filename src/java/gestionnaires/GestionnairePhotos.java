/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import java.util.Collection;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import modeles.Annonce;
import modeles.Photo;

/**
 *
 * @author thais
 */
@Stateless
public class GestionnairePhotos {
    
    @PersistenceContext
    private EntityManager em;
    
    public Collection<Photo> getPhotos() {
        Query q = em.createQuery("select p from Photo p");
        return q.getResultList();
    }
    
    public Collection<Photo> getPhotos(int start, int nParPage) {
        Query q = em.createQuery("select p from Photo p");
        q.setFirstResult(start);
        q.setMaxResults(nParPage);
        return q.getResultList();
    }
    
    public Photo getPhoto(int idPhoto) {
        Query q = em.createQuery("select p from Photo p where p.id = :id");
        q.setParameter("id", idPhoto);
        return (Photo) q.getSingleResult();
    }
    
    public void supprimerPhoto(int id) {
        Photo p = em.find(Photo.class, id);
        Annonce a = p.getAnnonce();
        a.getPhotos().remove(p);
        em.remove(p);
    }
    
    
}
