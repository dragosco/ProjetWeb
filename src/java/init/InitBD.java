/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package init;

import gestionnaires.GestionnaireUtilisateurs;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
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

    @PostConstruct
    public void init() {
        //File photo = new File("C:\\Users\\Dragos\\Documents\\NetBeansProjects\\ProjetWeb\\web\\resources\\photo.jpg");
        //InputStream is = new FileInputStream(photo);
        gu.creerUtilisateur("COJOCARU", "Dragos", "adminDragos", "admin", "UNice", "cojocaru.dragos14@gmail.com", "0687711971");
        gu.creerUtilisateur("MOTA DOS SANTOS", "Thais", "adminThais", "admin", "UNice", "tais.motasantos@gmail.com", "06*******");
    }
}
