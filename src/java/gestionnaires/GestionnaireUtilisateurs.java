/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@Stateless
public class GestionnaireUtilisateurs {
    @PersistenceContext
    private EntityManager em;
    
    public void creerUtilisateursDeTest() {
        
        for (int i = 0; i < 10; i++) {
            creerUtilisateur("nom"+i, "prenom"+i, "pseudo"+i, "motDePasse"+i, "ecole"+i, "mail"+i, "tel"+i);
        }
    }

    public Utilisateur creerUtilisateur(String nom, String prenom, String pseudo, String motDePasse, String ecole, String mail, String tel) {
        Utilisateur u = new Utilisateur(nom, prenom, pseudo, motDePasse, ecole, mail, tel);
        em.persist(u);
        return u;
    }
    
    public Utilisateur getUtilisateur(String pseudo) {
        Query q = em.createQuery("select u from UtilisateurOMBid u where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        return (Utilisateur) q.getSingleResult();
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
        Query q = em.createQuery("update UtilisateurOMBid u set u.motDePasse = :motDePasse where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("motDePasse", motDePasse);
        q.executeUpdate();
    }
    
    public void changeNom(String pseudo, String nom) {
        Query q = em.createQuery("update UtilisateurOMBid u set u.nom = :nom where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("nom", nom);
        q.executeUpdate();
    }
    
    public void changePrenom(String pseudo, String prenom) {
        Query q = em.createQuery("update UtilisateurOMBid u set u.prenom = :prenom where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("prenom", prenom);
        q.executeUpdate();
    }
    
    public void changeEcole(String pseudo, String ecole) {
        Query q = em.createQuery("update UtilisateurOMBid u set u.ecole = :ecole where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("ecole", ecole);
        q.executeUpdate();
    }
    
    public void changeMail(String pseudo, String mail) {
        Query q = em.createQuery("update UtilisateurOMBid u set u.mail = :mail where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("mail", mail);
        q.executeUpdate();
    }
    
    public void changeTel(String pseudo, String tel) {
        Query q = em.createQuery("update UtilisateurOMBid u set u.tel = :tel where u.pseudo = :pseudo");
        q.setParameter("pseudo", pseudo);
        q.setParameter("tel", tel);
        q.executeUpdate();
    }
}
