/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import modeles.Utilisateur;
import outils.InputStreamToByteArray;

/**
 *
 * @author Dragos
 */
@Stateless
public class GestionnaireUtilisateurs {
    @PersistenceContext
    private EntityManager em;

    public Utilisateur creerUtilisateur(String nom, String prenom, String pseudo, String motDePasse, String ecole, String mail, String tel, String privilege, byte[] photo) {
        Utilisateur u = new Utilisateur(nom, prenom, pseudo, motDePasse, ecole, mail, tel, privilege, photo);
        em.persist(u);
        return u;
    }
    
    public Collection<Utilisateur> getUtilisateurs() {
        Query q = em.createQuery("select u from Utilisateur u");
        return q.getResultList();
    }
    
    public Utilisateur getUtilisateur(String pseudo) {
        try{
            Query q = em.createQuery("select u from Utilisateur u where u.pseudo = :pseudo");
            q.setParameter("pseudo", pseudo);
            return (Utilisateur) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    
    public Utilisateur getUtilisateur(int id) {
        try{
            Query q = em.createQuery("select u from Utilisateur u where u.id = :id");
            q.setParameter("id", id);
            return (Utilisateur) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
    
    public void updateProfil(String pseudo, String motDePasse, String nom, String prenom, String ecole, String mail, String tel) {
        Query q = em.createQuery(
                "update UtilisateurOMBid u set "
                        + "u.motDePasse = :motDePasse, "
                        + "u.nom = :nom, "
                        + "u.prenom = :prenom, "
                        + "u.ecole = :ecole, "
                        + "u.mail = :mail, "
                        + "u.tel = :tel "
                            + "where u.pseudo = :pseudo"
        );
        q.setParameter("pseudo", pseudo);
        q.setParameter("motDePasse", motDePasse);
        q.setParameter("nom", nom);
        q.setParameter("prenom", prenom);
        q.setParameter("ecole", ecole);
        q.setParameter("mail", mail);
        q.setParameter("tel", tel);
        q.executeUpdate();
    }
    
    public void changeMotDePasse(String pseudo, String motDePasse) {
        Query q = em.createQuery("update Utilisateur u set u.motDePasse = :motDePasse where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("motDePasse", motDePasse);
        q.executeUpdate();
    }
    
    public void changeNom(String pseudo, String nom) {
        Query q = em.createQuery("update Utilisateur u set u.nom = :nom where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("nom", nom);
        q.executeUpdate();
    }
    
    public void changePrenom(String pseudo, String prenom) {
        Query q = em.createQuery("update Utilisateur u set u.prenom = :prenom where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("prenom", prenom);
        q.executeUpdate();
    }
    
    public void changeEcole(String pseudo, String ecole) {
        Query q = em.createQuery("update Utilisateur u set u.ecole = :ecole where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("ecole", ecole);
        q.executeUpdate();
    }
    
    public void changeMail(String pseudo, String mail) {
        Query q = em.createQuery("update Utilisateur u set u.mail = :mail where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("mail", mail);
        q.executeUpdate();
    }
    
    public void changeTel(String pseudo, String tel) {
        Query q = em.createQuery("update Utilisateur u set u.tel = :tel where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("tel", tel);
        q.executeUpdate();
    }
    
    public void changePrivilege(String pseudo, String privilege) {
        Query q = em.createQuery("update Utilisateur u set u.privilege = :privilege where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("privilege", privilege);
        q.executeUpdate();
    }
    
    public void changePhoto(String pseudo, byte[] photo) {
        Query q = em.createQuery("update Utilisateur u set u.photo = :photo where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("photo", photo);
        q.executeUpdate();
    }
    
    public void supprimerUtilisateur(String pseudo) {
        Query q = em.createQuery("delete from Utilisateur u where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.executeUpdate();
    }
    
    public Collection<Utilisateur> filtre(String pseudo, String nom, String ecole) {
        String filtre = "select u from Utilisateur u";
        if(!pseudo.equals("")) {
            filtre += " where u.pseudo = :pseudo";
            
            if (!nom.equals("")) {
                filtre += " and u.nom = :nom";
            }
            if (!ecole.equals("")) {
                filtre += " and u.ecole.nom = :ecole";
            }
            
        } else {
            if (!nom.equals("")) {
                filtre += " where u.nom = :nom";
                
                if (!ecole.equals("")) {
                    filtre += " and u.ecole.nom = :ecole";
                }
            } else {
                if (!ecole.equals("")) {
                    filtre += " where u.ecole.nom = :ecole";
                }
            }
        }
        
        Query q = em.createQuery(filtre);
        if(!pseudo.equals(""))
            q.setParameter("pseudo", pseudo);
        if(!nom.equals(""))
            q.setParameter("nom", nom);
        if(!ecole.equals(""))
            q.setParameter("ecole", ecole);
        
        
        return q.getResultList();
    }
    
    public boolean verifierAuthentification(String pseudo, String motDePasse) {
        boolean OK = false;
        if (getUtilisateur(pseudo) != null) {
            Utilisateur u = this.getUtilisateur(pseudo);
            if (u.getMotDePasse().equals(motDePasse)) {
                OK = true;
            }
        }
        return OK;
    }
    
}
