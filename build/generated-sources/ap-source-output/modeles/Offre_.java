package modeles;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modeles.Utilisateur;

<<<<<<< HEAD
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-03-29T08:12:12")
=======
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-03-28T19:03:24")
>>>>>>> ac13182664454e154c01d1ae2fbcaddd072330df
@StaticMetamodel(Offre.class)
public class Offre_ { 

    public static volatile SingularAttribute<Offre, Date> dateDepot;
    public static volatile SingularAttribute<Offre, byte[]> img;
    public static volatile SingularAttribute<Offre, String> categorie;
    public static volatile SingularAttribute<Offre, Double> prix;
    public static volatile SingularAttribute<Offre, String> titre;
    public static volatile SingularAttribute<Offre, String> description;
    public static volatile SingularAttribute<Offre, Integer> id;
    public static volatile SingularAttribute<Offre, Date> dateFin;
    public static volatile SingularAttribute<Offre, Utilisateur> auteur;

}