/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package init;

import gestionnaires.GestionnaireOffres;
import gestionnaires.GestionnaireUtilisateurs;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import modeles.Utilisateur;

/**
 *
 * @author Dragos
 */
@Singleton
@Startup
public class InitBD {
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnaireOffres go;

    @PostConstruct
    public void init() {
        //File photo = new File("C:\\Users\\Dragos\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\photo.jpg");
        //InputStream is = new FileInputStream(photo);
        gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "UNice", "cojocaru.dragos14@gmail.com", "0687711971");
        gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "UNice", "tais.motasantos@gmail.com", "06*******");
        go.creerOffre("titre1", "categorie1", 10, "description1", null, null, "adminThais");
        go.creerOffre("titre2", "categorie2", 10, "description2", null, null, "adminDragos");
        go.creerOffre("titretitretitretitretitre", "categorie3", 10, "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", null, null, "adminThais");
    }
}
