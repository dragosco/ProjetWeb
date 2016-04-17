/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import java.util.Collection;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import modeles.Ecole;

/**
 *
 * @author thais
 */
@Stateless
public class GestionnaireEcoles {

    @PersistenceContext
    private EntityManager em;

    
    public Ecole creerEcole(String nom) {
        Ecole c = new Ecole(nom);
        em.persist(c);
        return c;
    }
    
    public void creerEcolesDefaut() {
        creerEcole("Unice");
        creerEcole("Skema");
    }
    
    public Collection<Ecole> getEcoles() {
        Query q = em.createQuery("select c from Ecole c order by c.nom");
        return q.getResultList();
    }
    
    public Ecole getEcole(String nom) {
        try{
            Query q = em.createQuery("select c from Ecole c where c.nom = :nom");
            q.setParameter("nom", nom);
            return (Ecole) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    
    public Ecole getEcole(int id) {
        try{
            Query q = em.createQuery("select c from Ecole c where c.id = :id");
            q.setParameter("id", id);
            return (Ecole) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    
//    public void ajouterPhoto(int idEcole, byte[] photo) {
//        if(photo != null) {
//            Ecole e = getEcole(idEcole);
//            Photo p = new Photo(photo);
//            p.setAnnonce(a);
//            em.persist(p);
//            e.addPhoto(p);
//        }
//    }
    
    public void supprimerCategorie(int id) {
        Query q = em.createQuery("delete from Ecole c where c.id = :id");
        q.setParameter("id", id);
        q.executeUpdate();
    }
    public void persist(Object object) {
        em.persist(object);
    }
}
