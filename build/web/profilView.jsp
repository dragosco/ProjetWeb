<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
    <div class="row">
        <div class="col-md-2">
                <h2>Profil</h2>
                <br>
                <img src="Image/auteur/${profil.id}" class="img-rounded photoEtudiant">
        </div>
        <div class="col-md-10">
            <div class="row">
                <h2>${profil.pseudo}</h2>
                <br>
                <span>Nom : </span>${profil.nom}
                <br>
                <span>Prenom : </span>${profil.prenom}
                <br>
                <span>Mail : </span>${profil.mail}
                <br>
                <span>Tel : </span>${profil.tel}
                <br>
            </div>
        </div>
    </div>
</div>
            
<div class="container">
    <h4> Les dernières annonces publiées par <span style="color: #398439;">${param.user}</span></h4>
    
    <ul class="list-group">
        <c:forEach var="a" items="${sesAnnonces}">
            
            <li class="list-group-item">
                <div class="annonce" style="position: relative;">
                    
                    <div class="couleurAnnonce col-md-1"></div>
                    <div class="infoEtudiant col-md-3">
                        <a href="Profil?user=${a.auteur.pseudo}"><img src="/home/thais/Imagens/eu.jpg" class="img-rounded photoEtudiant"></a>
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