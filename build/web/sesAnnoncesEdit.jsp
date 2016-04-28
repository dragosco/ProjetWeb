<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<ul class="list-group">
    <c:forEach var="a" items="${requestScope.sesAnnonces}">
        <c:forEach var="p" items="${a.photos}">
            <c:set var="totalPhotos" value="${totalPhotos+1}"/>
        </c:forEach>
        <div style="text-align: right; margin-top: 20px;">
            <a class="outil-link view" href="Annonce?id=${a.id}" data-toggle="tooltip" data-placement="top" title="Visualiser l'annonce"><span class="glyphicon glyphicon-eye-open"></span></a>
            <span data-toggle="modal" data-target="#modalEditAnnc${a.id}">
                <a class="outil-link edit" type="submit" data-toggle="tooltip" data-placement="top" title="Editer l'annonce"><span class="glyphicon glyphicon-pencil"></span></a>
            </span>
            <span data-toggle="modal" data-target="#modalSupprAnnc${a.id}">
                <a class="outil-link suppr" type="submit" data-toggle="tooltip" data-placement="top" title="Supprimer l'annonce"><span class="glyphicon glyphicon-remove"></span></a>
            </span>
        </div>
        <li class="list-group-item list-carree-item">
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
                        <span class="too-long-text" data-toggle="tooltip" data-placement="top" title="${a.description}">Description : ${a.description}</span>
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
