<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h3>Editer vos annonces</h3>
    
    <ul class="list-group">
        <c:forEach var="a" items="${sesAnnonces}">
            <li class="list-group-item">
                <div class="annonce" style="position: relative;">
                    <button class="link-like-button" type="submit" data-toggle="modal" data-target="#modalSupprAnnc${a.id}" style="float:right;"><span class="glyphicon glyphicon-remove"></span></button>
                    <div class="modal fade" id="modalSupprAnnc${a.id}" role="dialog">
                      <div class="modal-dialog">
                        <div class="modal-content">
                            Etes-vous certain de vouloir supprimer cette annonce ?
                            <form action="Admin" method="post">
                                <input type="hidden" value="${a.id}" name="id" />
                                <button type="submit" value="supprimerAnnonce" name="action">Confirmer</button>
                                <hr>
                                <a href="Profil?user=${sessionScope.USER}&action=afficheAnnonces">Annuler</a>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="couleurAnnonce col-md-1"></div>
                    <div class="infoEtudiant col-md-3">
                        <a href="Profil?user=${a.auteur.pseudo}"><img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant"></a>
                        <p>${a.auteur.prenom} ${a.auteur.nom}</p>
                        <p>${a.auteur.ecole}</p>
                    </div>
                    <div class="infoProduit col-md-4">
                        <p>${a.titre}</p>
                        <p>${a.categorie}</p>
                        <p>Date ajout : <fmt:formatDate type="both" value="${a.dateDepot}" /></p>
                        <p>Date fin : <fmt:formatDate type="date" value="${a.dateFin}" /></p>
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
