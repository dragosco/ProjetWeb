<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<ul class="list-group">
    <c:forEach var="a" items="${requestScope.sesAnnonces}">
        <div style="text-align: right; margin-top: 20px;">
            <a class="outil-link view" href="Annonce?id=${a.id}" data-toggle="tooltip" data-placement="top" title="Visualiser l'annonce"><span class="glyphicon glyphicon-eye-open"></span></a>
            <span data-toggle="modal" data-target="#modalEditAnnc${a.id}">
                <a class="outil-link edit" type="submit" data-toggle="tooltip" data-placement="top" title="Editer l'annonce"><span class="glyphicon glyphicon-pencil"></span></a>
                </span>
                <div class="modal fade" id="modalEditAnnc${a.id}" role="dialog">
                    <div class="modal-dialog">
                        <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                        <div class="modal-content">
                            <h4 style="color: #00585F;">Effectuer des changements sur l'annonce</h4>
                            <form action="Profil" method="post">
                                <input type="hidden" name="id" value="${a.id}"/>
                                <button class="btn btn-success" type="submit" name="action" value="editAnnonce">Valider</button>
                            </form>
                        </div>
                    </div>
                </div>
            <span data-toggle="modal" data-target="#modalSupprAnnc${a.id}">
                <a class="outil-link suppr" type="submit" data-toggle="tooltip" data-placement="top" title="Supprimer l'annonce"><span class="glyphicon glyphicon-remove"></span></a>
                </span>
                <div class="modal fade" id="modalSupprAnnc${a.id}" role="dialog">
                    <div class="modal-dialog">
                        <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                        <div class="modal-content">
                            <h4 style="color: #00585F;">Etes-vous sûr de vouloir supprimer cette annonce ?</h4>
                            <form action="Profil" method="post">
                                <input type="hidden" name="id" value="${a.id}"/>
                                <button class="btn btn-danger right" type="submit" name="action" value="supprimerAnnonce">OUI</button>
                                <button class="btn btn-success left" type="button" data-dismiss="modal">NON</button>
                                
                            </form>
                        </div>
                    </div>
                </div>
        </div>
        <li class="list-group-item list-carree-item">
            <div class="row">
                <div class="col-md-2">
                    <div class="photo-annonce-wrapper">
                        <img class="photo-annonce" src="Image/produit/${a.photos[0].id}">
                    <br>
                    <a href="#" type="submit" data-toggle="modal" data-target="#modalAnncPhotos${a.id}">${fn:length(a.photos)}</a> photo(s) chargée(s)
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
                            <i>Sans date de validité</i>
                        </c:if>
                    </div>
                </div>
            </div>
        </li>
        <c:set var="totalPhotos" value="0"/>
    </c:forEach>
</ul>
