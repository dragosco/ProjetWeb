/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestionnaires;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
    

    public Annonce creerAnnonce(String titre, int type, int categorie, double prix, String description, Date dateFin, String auteur, Collection<byte[]> photos) {
        Utilisateur user = gu.getUtilisateur(auteur);
        //System.out.println("categorie : " + categorie);
        Categorie categ = gc.getCategorie(categorie);
        //System.out.println("categ " + categ);
        Annonce a = new Annonce(titre, type, categ, prix, description, dateFin, user);
        a.setDateDepot(new Date());
        if(photos != null) {
            for(byte[] photo : photos) {
                //System.out.print("entrou add photo");
                if (photo != null) {
                    Photo p = new Photo(photo);
                    p.setAnnonce(a);
                    em.persist(p);
                    a.addPhoto(p);
                }
            }
        }
        em.persist(a);
        gu.ajouterAnnonce(user.getId(),a);
        return a;
       
    }
    
    public Annonce creerAnnonce(String titre, int type, String categorie, double prix, String description, Date dateFin, String auteur, Collection<byte[]> photos) {
        Utilisateur user = gu.getUtilisateur(auteur);
        //System.out.println("categorie : " + categorie);
        Categorie categ = gc.getCategorie(categorie);
        //System.out.println("categ " + categ);
        Annonce a = new Annonce(titre, type, categ, prix, description, dateFin, user);
        a.setDateDepot(new Date());
        if(photos != null) {
            for(byte[] photo : photos) {
                if (photo != null) {
                    Photo p = new Photo(photo);
                    p.setAnnonce(a);
                    em.persist(p);
                    a.addPhoto(p);
                }
            }
        }
        em.persist(a);
        gu.ajouterAnnonce(user.getId(),a);
        return a;
       
    }
    
    private Query buildQuery(String motscles, int categorie, int ecole, String etudiant, String prix, int annonceType, String query, boolean isOrdonne) {
        
        // debut de la contruction de la requete   
        System.out.println("(categorie : " + categorie);
        query += "where (((:categorie = 0) or (a.categorie.id = :categorie)) "
            + "and ((:ecole = 0) or (a.auteur.ecole.id = :ecole)) "
            + "and (a.type = :annonceType) ";
        
        // filtre par nom de l'etudiant
        String[] nomsAuteur = null;
        System.out.println("(etudiant : " + etudiant);
        if(!etudiant.isEmpty()) {        
            nomsAuteur = etudiant.trim().split(" +");
            if(nomsAuteur.length > 0) {
                query += "and ((:nomsAuteur0 = '')";
                System.out.println("(etudiant : " + nomsAuteur[0] + ")");

                for (int i = 0; i < nomsAuteur.length; i++) {
                    query += " or (UPPER(a.auteur.nom) like UPPER(:nomsAuteur" + i + ")) or (UPPER(a.auteur.prenom) like UPPER(:nomsAuteur" + i + "))";
                }

                query += ") ";
            }
        }
        
        // filtre par mots-cles
        String[] motsClesParts = null;
        
        if(!motscles.isEmpty()) {        
            motsClesParts = motscles.trim().split(" +");
            if(motsClesParts.length > 0) {
                query += "and ((:motsClesParts0 = '')";

                for (int i = 0; i < motsClesParts.length; i++) {
                    query += " or (UPPER(a.titre) like UPPER(:motsClesParts" + i + ")) or (UPPER(a.description) like UPPER(:motsClesParts" + i + "))";
                }

                query += ") ";
            }
        }

        // filtre par prix min et max
        System.out.println("prix : " + prix);
        
        String[] intervalePrix = prix.split(" - ");
        
        Pattern pattern = Pattern.compile("[0-9]+");
        Matcher matcher = pattern.matcher(intervalePrix[0]);
        String prixMin = "";
        if (matcher.find())
        {
            prixMin = matcher.group(0);
        }
        
        String prixMax = "";
        if(intervalePrix.length > 1) {
            matcher = pattern.matcher(intervalePrix[1]);
            if (matcher.find())
            {
                prixMax = matcher.group(0);
            }
        }
        
        query += "and ((:prixMin = '') or (a.prix >= CAST(:prixMin as DECIMAL(9,2)))) ";
        query += "and ((:prixMax = '') or (a.prix <= CAST(:prixMax as DECIMAL(9,2))))) ";
        
        if(isOrdonne) {
            query += "order by a.dateDepot desc";
        }
        
        //query += "order by a.dateDepot desc";

        System.out.println("query : " + query);
        
        // fin de la contruction de la requete
        // debut du setParameter
        Query q = em.createQuery(query);
        q.setParameter("categorie", categorie);
        q.setParameter("ecole", ecole);
        q.setParameter("annonceType", annonceType);
        System.out.println("annonceType " + annonceType);
        
        if(!etudiant.isEmpty()) {        
            for (int i = 0; i < nomsAuteur.length; i++) {
                q.setParameter("nomsAuteur" + i, '%' + nomsAuteur[i] + '%');
            }
        }
        
        if(!motscles.isEmpty()) {        
            for (int i = 0; i < motsClesParts.length; i++) {
                q.setParameter("motsClesParts" + i, '%' + motsClesParts[i] + '%');
            }
        }
        
        q.setParameter("prixMin", prixMin);
        q.setParameter("prixMax", prixMax);
        // fin du setParameter
        
        return q;
    }
    
    public long getCountAnnonces(String motscles, int categorie, int ecole, String etudiant, String prix, int annonceType) {
        
        String query = "select count(a) as total from Annonce a ";
        Query q = buildQuery(motscles, categorie, ecole, etudiant, prix, annonceType, query, false);
        return (long) q.getResultList().get(0);
    }
    
    public long getCountAnnonces() {        
        Query q = em.createQuery("select count(a) from Annonce a"); 
        return (long) q.getResultList().get(0);
    }

    public Collection<Annonce> getAnnonces() {
        // Exécution d'une requête équivalente à un select *
        Query q = em.createQuery("select a from Annonce a order by a.dateDepot desc");       
        return q.getResultList();
    }

    public Collection<Annonce> getAnnonces(String motscles, int categorie, int ecole, String etudiant, String prix, int annonceType, String debut, String nombreParPage) {
        String query = "select a from Annonce a ";
        Query q = buildQuery(motscles, categorie, ecole, etudiant, prix, annonceType, query, true);
        q.setFirstResult(Integer.parseInt(debut));
        q.setMaxResults(Integer.parseInt(nombreParPage));
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
    
    public Double getMinPrix(int annonceType) {
        Query q = em.createQuery("select min(a.prix) from Annonce a where a.type = :annonceType");
        q.setParameter("annonceType", annonceType);
        Double minPrix = (Double) q.getSingleResult();
        return minPrix;
    }
    
    public Double getMaxPrix(int annonceType) {
        //Double maxPrix = (Double) em.createNativeQuery("select max(a.prix) from Annonce a").getSingleResult();
        
        Query q = em.createQuery("select max(a.prix) from Annonce a where a.type = :annonceType");
        q.setParameter("annonceType", annonceType);
        Double maxPrix = (Double) q.getSingleResult();
        
        return maxPrix;
    }
    
    public void supprimerAnnonce(int id) {
        Annonce a = em.find(Annonce.class, id);
        em.remove(a);
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
