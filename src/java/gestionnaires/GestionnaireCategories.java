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
import modeles.Categorie;

/**
 *
 * @author Dragos
 */
@Stateless
public class GestionnaireCategories {
    
    @PersistenceContext
    private EntityManager em;

    
    public Categorie creerCategorie(String nom) {
        Categorie c = new Categorie(nom);
        em.persist(c);
        return c;
    }
    
    public void creerCategoriesDefaut() {
        creerCategorie("Stage");
        creerCategorie("Vehicules");
        creerCategorie("Immobilier");
        creerCategorie("Vacances");
        creerCategorie("Maison");
        creerCategorie("Vêtements");
        creerCategorie("Chaussures");
        creerCategorie("Multimédia");
        creerCategorie("Loisirs");
        creerCategorie("Matériel PRO");
        creerCategorie("Services");
        creerCategorie("Autres");
    }
    public Collection<Categorie> getCategories() {
        Query q = em.createQuery("select c from Categorie c order by c.nom");
        return q.getResultList();
    }
    public Categorie getCategorie(String nom) {
        try{
            Query q = em.createQuery("select c from Categorie c where c.nom = :nom");
            q.setParameter("nom", nom);
            return (Categorie) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    public void supprimerCategorie(int id) {
        Categorie c = em.find(Categorie.class, id);
        em.remove(c);
    }
    
    public void persist(Object object) {
        em.persist(object);
    }

    
}
