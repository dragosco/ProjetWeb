/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeles;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Dragos
 */
@Entity(name="Annonce")
public class Annonce implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;
    
    private int type;
    private String titre;
    @ManyToOne
    private Categorie categorie;
    private double prix;
    private String description;
    
    @OneToMany(cascade={CascadeType.ALL},
            fetch=FetchType.EAGER,
            mappedBy="annonce", orphanRemoval = true)
    private Collection<Photo> photos;
    
    @Temporal(TemporalType.DATE)
    private Date dateDepot;
    @Temporal(TemporalType.DATE)
    private Date dateFin;
    
    @ManyToOne
    private Utilisateur auteur;
    
    public Annonce() {
    }

    public Annonce(String titre, int type, Categorie categorie, double prix, String description, Date dateFin, Utilisateur auteur) {
        this.titre = titre;
        this.type = type;
        this.categorie = categorie;
        this.prix = prix;
        this.description = description;
        this.dateFin = dateFin;
        this.auteur = auteur;
        this.photos = new ArrayList<Photo>();
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
    
    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Collection<Photo> getPhotos() {
        return photos;
    }
    
    public void setPhotos(Collection<Photo> photos) {
        this.photos = photos;
    }

    public Date getDateDepot() {
        return dateDepot;
    }

    public void setDateDepot(Date dateDepot) {
        this.dateDepot = dateDepot;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }
    

    public Utilisateur getAuteur() {
        return auteur;
    }

    public void setAuteur(Utilisateur auteur) {
        this.auteur = auteur;
    }
    
    public void addPhoto(Photo photo) {
        photos.add(photo);
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) id;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Annonce)) {
            return false;
        }
        Annonce other = (Annonce) object;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modeles.Annonce[ id=" + id + " ]";
    }
    
}
