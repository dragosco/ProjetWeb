/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeles;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 *
 * @author thais
 */
@Entity
public class Ecole implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String nom;

    @OneToMany(cascade = {CascadeType.ALL},
            fetch = FetchType.EAGER,
            mappedBy = "ecole")
    private Collection<Utilisateur> etudiants;

    public Ecole() {
        
    }
    
    public Ecole(String nom) {
        this.nom = nom;
        this.etudiants = new ArrayList<Utilisateur>();
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Collection<Utilisateur> getEtudiants() {
        return etudiants;
    }

    public void setEtudiants(Collection<Utilisateur> etudiants) {
        this.etudiants = etudiants;
    }
    
    public void addEtudiant(Utilisateur etudiant) {
        etudiants.add(etudiant);
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
        if (!(object instanceof Ecole)) {
            return false;
        }
        Ecole other = (Ecole) object;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modeles.Ecole[ id=" + id + " ]";
    }

}
