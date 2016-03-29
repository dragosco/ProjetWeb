package modeles;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modeles.Offre;

<<<<<<< HEAD
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-03-29T08:12:12")
=======
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-03-28T19:03:24")
>>>>>>> ac13182664454e154c01d1ae2fbcaddd072330df
@StaticMetamodel(Utilisateur.class)
public class Utilisateur_ { 

    public static volatile SingularAttribute<Utilisateur, String> motDePasse;
    public static volatile SingularAttribute<Utilisateur, String> mail;
    public static volatile CollectionAttribute<Utilisateur, Offre> offres;
    public static volatile SingularAttribute<Utilisateur, String> ecole;
    public static volatile SingularAttribute<Utilisateur, byte[]> photo;
    public static volatile SingularAttribute<Utilisateur, String> tel;
    public static volatile SingularAttribute<Utilisateur, Integer> id;
    public static volatile SingularAttribute<Utilisateur, String> nom;
    public static volatile SingularAttribute<Utilisateur, String> prenom;
    public static volatile SingularAttribute<Utilisateur, String> pseudo;

}