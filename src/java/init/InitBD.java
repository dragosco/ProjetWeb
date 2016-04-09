/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package init;

import gestionnaires.GestionnaireAnnonces;
import gestionnaires.GestionnaireCategories;
import gestionnaires.GestionnaireUtilisateurs;
import java.io.File;
import java.io.FileInputStream;
import static java.lang.System.gc;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.ejb.Startup;

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
    private GestionnaireAnnonces ga;
    @EJB
    private GestionnaireCategories gc;

    @PostConstruct
    public void init() {
        
        
//        File file = new File("C:/Users/Dragos/WebstormProjects/mySite/resources/logo.png");
//        FileInputStream fileInputStream = null;
//        
//        byte[] bFile = new byte[(int) file.length()];
//        
//        try {
//            //convert file into array of bytes
//            fileInputStream = new FileInputStream(file);
//	    fileInputStream.read(bFile);
//	    fileInputStream.close();
//        } catch (Exception ex) {
//            Logger.getLogger(InitBD.class.getName()).log(Level.SEVERE, null, ex);
//        }
        
        File file2 = new File("C:\\Users\\Dragos\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\dragos.jpg");
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
        
        File file3 = new File("C:\\Users\\Dragos\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\thais.jpg");
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
//            
//            gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "UNice", "cojocaru.dragos14@gmail.com", "0687711971", "admin", bFile2);
//            gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "UNice", "thais.motasantos@gmail.com", "06*******", "admin", bFile2);
//            ga.creerAnnonce("titre1", "categorie1", 10, "description1", null, "adminThais", bFile);
//            ga.creerAnnonce("titre2", "categorie2", 10, "description2", null, "adminDragos", bFile);
//            ga.creerAnnonce("titretitretitretitretitre", "categorie3", 10, "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", null, "adminThais", bFile);
//        }
        gc.creerCategoriesDefaut();
        
        gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "UNice", "cojocaru.dragos14@gmail.com", "0687711971", "admin", bFile2);
        gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "UNice", "thais.motasantos@gmail.com", "06*******", "admin", bFile3);
        gu.creerUtilisateur("Potter", "Harry", "hp", "hp", "UNice", "hp@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Granger", "Hermione", "hermy", "hermy", "SKEMA", "hermy@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Weasley", "Ronald", "ronnie", "ronnie", "SKEMA", "ronnieW@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Longbottom", "Neville", "bottom", "bottom", "UNice", "lbtm@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Dupont", "Nathalie", "dun", "dun", "SKEMA", "dun@gmail.com", "06*******", "user", null);
        gu.creerUtilisateur("Dupont", "Jean", "duj", "duj", "UNice", "duj@gmail.com", "06*******", "user", null);

        
    }
}
