/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
            creeUtilisateur("nom"+i, "prenom"+i, "pseudo"+i, "motDePasse"+i, "ecole"+i, "mail"+i, "tel"+i);
        }
    }

    public Utilisateur creeUtilisateur(String nom, String prenom, String pseudo, String motDePasse, String ecole, String mail, String tel) {
        Utilisateur u = new Utilisateur(nom, prenom, pseudo, motDePasse, ecole, mail, tel);
        em.persist(u);
        return u;
       
    }
}
