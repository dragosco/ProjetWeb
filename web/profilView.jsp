<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="row">
    <div class="contenu contenu-profil col-md-5">
        <div class="photo-profil-wrapper">
            <c:choose>
                <c:when test="${profil.photo != null}">
                    <img class="img-circle photoEtudiant-profil"src="Image/auteur/${profil.id}">
                </c:when>
                <c:otherwise>
                    <img class="img-circle photoEtudiant-profil" src="resources/default_profile.jpg">
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="contenu contenu-profil col-md-7">
        
            <h2>${profil.pseudo} <span class="text-aside">(${profil.prenom} ${profil.nom})</span></h2>
            <hr>
            <div class="row details-profils">
                <div class="col-md-2">
                    <span class="glyphicon glyphicon-education"></span>
                </div>
                <div class="col-md-10">
                    ${profil.ecole.nom}
                </div>
            </div>
            <div class="row details-profils">
                <div class="col-md-2">
                    <span class="glyphicon glyphicon-earphone"></span>
                </div>
                <div class="col-md-10">
                    ${profil.tel}
                </div>
            </div>
            <div class="row details-profils">
                <div class="col-md-2">
                    <span class="glyphicon glyphicon-envelope"></span>
                </div>
                <div class="col-md-10">
                    ${profil.mail}
                </div>
                
            </div>
            
    </div>
</div>

<div class="row">
    
    <div class="col-md-12">
        <span style="padding: 10px; font-size: 18px; color: #00585F; text-align: left;">Les annonces de ${profil.prenom}</span>
    <hr>
        <ul class="list-group">
            <c:forEach var="a" items="${requestScope.sesAnnonces}">
                <c:forEach var="p" items="${a.photos}">
                    <c:set var="totalPhotos" value="${totalPhotos+1}"/>
                </c:forEach>
                <li class="list-group-item list-carree-item" style="margin-top: 20px;">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="photo-annonce-wrapper">
                                <img src="Image/produit/${a.photos[0].id}" style="max-height: 150px; width: auto">
                            <br>
                            <a href="#" type="submit" data-toggle="modal" data-target="#modalAnncPhotos${a.id}">${totalPhotos}</a> photo(s) chargée(s)
                            <div class="modal fade" id="modalAnncPhotos${a.id}" role="dialog">
                                <div class="modal-dialog">
                                    <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                                    <div class="modal-content" style="padding: 0; background-color: transparent; box-shadow: none;">
                                        <c:forEach var="p" items="${a.photos}">
                                            <div class="imageWrapper" style="width: 100%;">
                                                <img src="Image/produit/${p.id}" style="width:100%;">
                                            </div>
                                        </c:forEach>
                                  </div>
                                </div>
                            </div>
                            </div>

                        </div>
                        <div class="col-md-10">
                            <div class="row list-item-header">
                                ${a.titre}
                            </div>
                            <div class="row list-item-contenu">
                                <span style="font-style: italic; color: grey;"><fmt:formatDate type="date" value="${a.dateDepot}" /> à <fmt:formatDate type="time" value="${a.dateDepot}" timeStyle="short" /></span>
                            </div>
                            <div class="row list-item-contenu">
                                <span>Catégorie : ${a.categorie.nom}</span>
                                <span style="float:right; font-size: 18px; color: #FF3800; font-weight: bold;">${a.prix} €</span>
                            </div>
                            <div class="row list-item-contenu">
                                Description : ${a.description}
                            </div>
                            <div class="row list-item-contenu">
                                <c:if test="${not empty a.dateFin}">
                                    Valable jusqu'au <fmt:formatDate type="date" value="${a.dateFin}" />
                                </c:if>
                                <c:if test="${empty a.dateFin}">
                                    <i>Sans date de valabilité</i>
                                </c:if>

                            </div>
                        </div>
                    </div>
                </li>
                <c:set var="totalPhotos" value="0"/>
            </c:forEach>
        </ul>
    </div>
</div>
