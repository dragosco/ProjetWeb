package modeles;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modeles.Annonce;
import modeles.Ecole;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-04-28T14:21:57")
@StaticMetamodel(Utilisateur.class)
public class Utilisateur_ { 

    public static volatile SingularAttribute<Utilisateur, String> motDePasse;
    public static volatile SingularAttribute<Utilisateur, String> mail;
    public static volatile CollectionAttribute<Utilisateur, Annonce> annonces;
    public static volatile SingularAttribute<Utilisateur, Ecole> ecole;
    public static volatile SingularAttribute<Utilisateur, byte[]> photo;
    public static volatile SingularAttribute<Utilisateur, String> tel;
    public static volatile SingularAttribute<Utilisateur, Integer> id;
    public static volatile SingularAttribute<Utilisateur, String> privilege;
    public static volatile SingularAttribute<Utilisateur, String> nom;
    public static volatile SingularAttribute<Utilisateur, String> prenom;
    public static volatile SingularAttribute<Utilisateur, String> pseudo;

}