/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package init;

import gestionnaires.GestionnaireUtilisateurs;
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
        gu.creeUtilisateur("admin", "admin", "admin", "admin", "admin", "admin", "admin");
    }
}
