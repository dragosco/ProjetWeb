<%-- 
    Document   : index
    Created on : 24 mars 2016, 14:50:35
    Authors     : Thais, Dragos
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>etumercatus</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery-2.2.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <div class="main">
                <div class="header">
                    <h3>${annonce.titre}</h3>
                </div>
                <c:if test="${fn:length(annonce.photos) > 0}">
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <c:set var="i" value="0" />
                            <c:forEach var="p" items="${annonce.photos}">
                                <c:if test="${i == 0}">
                                    <li data-target="#myCarousel" data-slide-to="${i}" class="active"></li>
                                </c:if>
                                <c:if test="${i != 0}">
                                    <li data-target="#myCarousel" data-slide-to="${i}"></li>
                                </c:if>
                                <c:set var="i" value="${i+1}" />
                            </c:forEach>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <c:set var="i" value="0" />
                            <c:forEach var="p" items="${annonce.photos}">
                                <c:if test="${i == 0}">
                                    <div class="item active">
                                        <img src="Image/produit/${p.id}" class="photoDetailProduit">
                                    </div>
                                </c:if>
                                <c:if test="${i != 0}">
                                    <div class="item">
                                        <img src="Image/produit/${p.id}" class="photoDetailProduit">
                                    </div>
                                </c:if>
                                <c:set var="i" value="${i+1}" />
                            </c:forEach>
                        </div>

                        <!-- Left and right controls -->
                        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </c:if>
                <div class="contenu" style="position: relative;">
                    <div class="row ligne-details-annonce">
                        <div class="col-md-12">
                            <span style="color: #FFF; background-color: #FF3800; border-radius: 10px; font-weight: bold; padding: 5px; text-align: center; display:block;"><c:if test="${annonce.type == 0}">VENTE</c:if><c:if test="${annonce.type == 1}">RECHERCHE</c:if></span>
                        </div>
                    </div>
                        
                    <div class="row ligne-details-annonce">
                        <div class="col-md-12">
                            <span style="color: grey; font-style: italic;">
                                <p>Annonce publiée le <fmt:formatDate type="date" value="${annonce.dateDepot}" /> à <fmt:formatDate type="time" value="${annonce.dateDepot}" timeStyle="short" /></p>
                                <p>
                                    <c:if test="${not empty a.dateFin}">
                                        Valable jusqu'au <fmt:formatDate type="date" value="${a.dateFin}" />
                                    </c:if>
                                    <c:if test="${empty a.dateFin}">
                                        Sans date de validité
                                    </c:if>
                                </p>
                            </span>
                            
                    </div>
                    </div>
                        
                    <div class="row ligne-details-annonce">
                        <div class="col-md-6">
                            <p>Auteur : <a href="Profil?user=${annonce.auteur.pseudo}">${annonce.auteur.prenom} ${annonce.auteur.nom}</a></p>
                            <p>Etudiant à : <span style="color: #FF3800">${annonce.auteur.ecole.nom}</span></p>
                        </div>
                        <div class="col-md-6" style="position: relative;">
                            <c:choose>
                                <c:when test="${annonce.auteur.photo != null}">
                                    <img src="Image/auteur/${annonce.auteur.id}" style="width: 64px; border-radius: 100%; float: right;">
                                </c:when>
                                <c:otherwise>
                                    <img src="resources/default_profile.jpg" style="width: 64px; border-radius: 100%; float: right;">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                        
                    <div class="row ligne-details-annonce">
                        <div class="col-md-4">
                            Prix : <span style="font-size: 18px; color: #FF3800; font-weight: bold;">${annonce.prix} ¤</span>
                        </div>
                            
                        <div class="col-md-8 text-justify">
                            Description : ${annonce.description}
                        </div>
                    </div>
                        
                    <div class="row ligne-details-annonce text-center">
                        <div class="col-md-12">
                            <c:if test="${sessionScope.PRIVILEGE == 'admin'}">
                                <a class="suppr" type="submit" data-toggle="modal" data-target="#modalSupprAnnc${annonce.id}" style="cursor: pointer;">Supprimer l'annonce</a>
                                <div class="modal fade" id="modalSupprAnnc${annonce.id}" role="dialog">
                                    <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            Etes-vous certain de vouloir supprimer cette annonce ?
                                            <form action="Admin" method="post">
                                                <input type="hidden" value="${annonce.id}" name="id" />
                                                <button class="btn btn-danger right" type="submit" name="action" value="supprimerAnnonce">OUI</button>
                                                <button class="btn btn-success left" type="button" data-dismiss="modal">NON</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>

