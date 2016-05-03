/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package init;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireEcoles;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import modeles.Photo;

/**
 *
 * @author Dragos
 */
@Singleton
@Startup
public class InitBD {
    @EJB
    private GestionnaireEcoles ge;
    @EJB
    private GestionnaireUtilisateurs gu;
    @EJB
    private GestionnaireAnnonces ga;
    @EJB
    private GestionnaireCategories gc;
    
    @PostConstruct
    public void init() {
        
        
        File file = new File("C:\\Users\\cojoc\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\blason-pa.png");
        FileInputStream fileInputStream = null;
        
        byte[] bFile = new byte[(int) file.length()];
        
        try {
            //convert file into array of bytes
            fileInputStream = new FileInputStream(file);
	    fileInputStream.read(bFile);
	    fileInputStream.close();
        } catch (Exception ex) {
            Logger.getLogger(InitBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        File file2 = new File("C:\\Users\\cojoc\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\dragos.jpg");
        FileInputStream fileInputStream2 = null;
        
        byte[] bFile2 = new byte[(int) file2.length()];
        
        try {
            //convert file into array of bytes
            fileInputStream2 = new FileInputStream(file2);
	    fileInputStream2.read(bFile2);
	    fileInputStream2.close();
        } catch (Exception ex) {
            Logger.getLogger(InitBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        File file3 = new File("C:\\Users\\cojoc\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\thais.jpg");
        FileInputStream fileInputStream3 = null;
        
        byte[] bFile3 = new byte[(int) file3.length()];
        
        try {
            //convert file into array of bytes
            fileInputStream3 = new FileInputStream(file3);
	    fileInputStream3.read(bFile3);
	    fileInputStream3.close();
        } catch (Exception ex) {
            Logger.getLogger(InitBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Collection<byte[]> photos = new ArrayList<byte[]>();
        photos.add(bFile);
        
//        gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "UNice", "cojocaru.dragos14@gmail.com", "0687711971", "admin", bFile2);
//        gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "UNice", "thais.motasantos@gmail.com", "06*******", "admin", bFile2);
//        ga.creerAnnonce("titre1", "categorie1", 10, "description1", null, "adminThais", photos);
//        ga.creerAnnonce("titre2", "categorie2", 10, "description2", null, "adminDragos", photos);
//        ga.creerAnnonce("titretitretitretitretitre", "categorie3", 10, "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", null, "adminThais", photos);
        
        gc.creerCategoriesDefaut();
        ge.creerEcolesDefaut();
        
        gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "Unice", "cojocaru.dragos14@gmail.com", "0687711971", "admin", bFile2);
        gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "Unice", "thais.motasantos@gmail.com", "06*******", "admin", bFile3);
        gu.creerUtilisateur("Potter", "Harry", "hp", "hp", "Unice", "hp@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Granger", "Hermione", "hermy", "hermy", "Skema", "hermy@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Weasley", "Ronald", "ronnie", "ronnie", "Skema", "ronnieW@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Longbottom", "Neville", "bottom", "bottom", "Unice", "lbtm@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Dupont", "Nathalie", "dun", "dun", "Skema", "dun@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Dupont", "Jean", "duj", "duj", "Skema", "duj@gmail.com", "06*******", "user", null);
        gu.creerUtilisateursDeTest();

        //String titre, String categorie, double prix, String description, Date dateFin, String auteur, byte[] photo
        
        ga.creerAnnonce("Smartphone samsung", "Multimédia", 200, "description", null, "adminThais", photos);
        ga.creerAnnonce("titre2", "Immobilier", 10, "description2", null, "adminDragos", photos);
        ga.creerAnnonce("titretitretitretitretitre", "Loisirs", 10, "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", null, "adminThais", photos);       
        ga.creerAnnonce("titre5", "Loisirs", 10, "desc", null, "duj", photos);       
    }
}
