<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
    <h3>Editer vos annonces</h3>
    
    <ul class="list-group">
        <c:forEach var="a" items="${sesAnnonces}">
            
            <li class="list-group-item">
                <div class="annonce" style="position: relative;">
                    <a href="Accueil?action=supprimerAnnonce&id=${a.id}" style="position: absolute; top:0; right:0; z-index:10;"><span class="glyphicon glyphicon-remove"></span></a>
                    
                    <div class="couleurAnnonce col-md-1"></div>
                    <div class="infoEtudiant col-md-3">
                        <a href="Profil?user=${a.auteur.pseudo}"><img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant"></a>
                        <p>${a.auteur.prenom} ${a.auteur.nom}</p>
                        <p>${a.auteur.ecole}</p>
                    </div>
                    <div class="infoProduit col-md-4">
                        <p>${a.titre}</p>
                        <p>${a.categorie}</p>
                        <p>Date</p>
                    </div>
                    <div class="prixProduit col-md-2">
                        <p>${a.prix} €</p>
                    </div>
                    <div class="photosProduit col-md-2">
                        <img src="Image/produit/${a.photos[0].id}" class="img-rounded photoProduit"/>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
