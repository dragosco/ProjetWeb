package modeles;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modeles.Categorie;
import modeles.Photo;
import modeles.Utilisateur;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-04-16T01:20:21")
@StaticMetamodel(Annonce.class)
public class Annonce_ { 

    public static volatile SingularAttribute<Annonce, Date> dateDepot;
    public static volatile SingularAttribute<Annonce, Categorie> categorie;
    public static volatile SingularAttribute<Annonce, Double> prix;
    public static volatile SingularAttribute<Annonce, String> titre;
    public static volatile SingularAttribute<Annonce, String> description;
    public static volatile SingularAttribute<Annonce, Integer> id;
    public static volatile SingularAttribute<Annonce, Date> dateFin;
    public static volatile CollectionAttribute<Annonce, Photo> photos;
    public static volatile SingularAttribute<Annonce, Utilisateur> auteur;

}