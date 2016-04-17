package modeles;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modeles.Annonce;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-04-16T01:20:21")
@StaticMetamodel(Categorie.class)
public class Categorie_ { 

    public static volatile CollectionAttribute<Categorie, Annonce> annonces;
    public static volatile SingularAttribute<Categorie, Integer> id;
    public static volatile SingularAttribute<Categorie, String> nom;

}