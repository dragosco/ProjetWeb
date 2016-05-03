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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>etumercatus</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        
        <script src="js/jquery-2.2.0.js"></script>
        <script src="js/main.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-scripts.js"></script>
        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script>
            $(function() {
              $("#slider-range").slider({
                range: true,
                min: ${minPrix},
                max: ${maxPrix},
                values: [${minPrix}, ${maxPrix}],
                slide: function(event, ui) {
                  $("#amount").val(ui.values[0] + "�" + " - " + ui.values[1] + "�");
                }
              });
              $("#amount").val($("#slider-range").slider("values", 0) + "�" +
                " - " + $("#slider-range").slider("values", 1) + "�" );
            });
        </script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <c:if test="${param.message == 'compteOK'}">
                <div class="alert alert-success" id="compteOK" role="alert">
                    F�licitations, votre compte a �t� cr�� avec succ�s <span class="glyphicon glyphicon-thumbs-up" style="width:30px;"></span> Vous pouvez vous connecter
                </div>
            </c:if>
            
            <c:if test="${param.message == 'echecDepotAnnonce'}">
                <div class="alert alert-warning" id="echecDepotAnnonce" role="alert">
                    <div class="row">
                        <div class="col-md-4">
                            <span class="glyphicon glyphicon-exclamation-sign" style="font-size: 48px; float:right;"></span>
                        </div>
                        <div class="col-md-8">
                            <span style="float:left;">
                                Il faut �tre connect� pour d�poser une annonce
                                <br>
                                Connectez-vous ou cr�ez un <a href="Compte">nouveau compte</a>
                            </span>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        
        <div class="container">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#ventesContainer">Ventes</a></li>
                <li><a data-toggle="tab" href="#recherchesContainer">Recherches</a></li>
            </ul>
            
            <div class="tab-content">
                <!-- VENTES -->
                <div class="tab-pane fade in active" id="ventesContainer">
                    <div class="container">
                        <form action="Accueil" method="get">
                            <div class="row">
                                <div class="col-md-6">
                                    Mots cl�s : <input class="form-control" type="text" name="motscles" />
                                    Cat�gorie : <select class="form-control" type="text" name="categorie">
                                                    <option value="" selected>Toutes</option>
                                                    <c:forEach var="c" items="${categories}">
                                                        <option value="${c.nom}">${c.nom}</option>
                                                    </c:forEach>
                                                </select>
                                    Prix :  <input type="text" id="amount" name="prix" readonly style="border:0; color:#f6931f; font-weight:bold;">
                                            <div id="slider-range"></div>
                                </div>
                                <div class="col-md-6">
                                    Ecole : <select class="form-control" type="text" name="ecole">
                                                <option value="" selected>Toutes</option>
                                                <c:forEach var="e" items="${ecoles}">
                                                    <option value="${e.nom}">${e.nom}</option>
                                                </c:forEach>
                                            </select>
                                    Etudiant :  <input class="form-control" type="text" name="etudiant" />
                                    <input type="hidden" name="typ" value="1" /> <!-- 1 correspond aux ventes -->
                                </div>  
                            </div>
                            <br>
                            <button class="btn btn-success" type="submit" value="filtrerAnnonces" name="action" style="float:right;">Chercher</button>
                        </form>
                    </div>
                    <br>
                    <div class="container">
                        <ul class="list-group">
                            <c:forEach var="a" items="${annonces}">
                                <li class="list-group-item">
                                    <div class="annonce row" style="position: relative;">
                                        <c:if test="${sessionScope.PRIVILEGE == 'admin'}">
                                            <a class="outil-link suppr on-element" type="submit" data-toggle="modal" data-target="#modalSupprAnnc${a.id}"><span class="glyphicon glyphicon-remove"></span></a>
                                            <div class="modal fade" id="modalSupprAnnc${a.id}" role="dialog">
                                              <div class="modal-dialog">
                                                <div class="modal-content">
                                                    Etes-vous certain de vouloir supprimer cette annonce ?
                                                    <form action="Admin" method="post">
                                                        <input type="hidden" value="${a.id}" name="id" />
                                                        <button type="submit" value="supprimerAnnonce" name="action">Confirmer</button>
                                                        <hr>
                                                        <a href="Accueil">Annuler</a>
                                                    </form>
                                                </div>
                                              </div>
                                            </div>
                                        </c:if>
                                        <div class="couleurAnnonce col-md-1"></div>
                                        <div class="infoEtudiant col-md-3">
                                            <a href="Profil?user=${a.auteur.pseudo}">
                                                <c:choose>
                                                    <c:when test="${a.auteur.photo != null}">
                                                        <img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="resources/default_profile.jpg" class="img-rounded photoEtudiant">
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <p>${a.auteur.prenom} ${a.auteur.nom}</p>
                                            <p>${a.auteur.ecole.nom}</p>
                                        </div>
                                        <div class="infoProduit col-md-4">
                                            <a href="Annonce?id=${a.id}"><p>${a.titre}</p></a>
                                            <p>${a.categorie.nom}</p>
                                            <p>Date ajout : <fmt:formatDate type="both" value="${a.dateDepot}" /></p>
                                            <p>Date fin : <fmt:formatDate type="date" value="${a.dateFin}" /></p>
                                        </div>
                                        <div class="prixProduit col-md-2">
                                            <p>${a.prix} �</p>
                                        </div>
                                        <div class="photosProduit col-md-2">
                                            <c:choose>
                                                <c:when test="${fn:length(a.photos) > 0}">
                                                    <p><img src="Image/produit/${a.photos[0].id}" class="img-rounded photoProduit"/></p>
                                                    <span class="iconPhoto">
                                                        <img src="resources/camera.png" class="icon"/>
                                                        <span class="nombrePhotos">
                                                            ${fn:length(a.photos)}
                                                        </span>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <p><img src="resources/no_foto.jpg" class="img-rounded photoProduit"></p>
                                                </c:otherwise>
                                            </c:choose>                                    
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
                <!-- RECHECHES -->
                <div class="tab-pane fade in" id="recherchesContainer">
                    <div class="container">
                        <form action="Accueil" method="get">
                            <div class="row">
                                <div class="col-md-6">
                                    Mots cl�s : <input class="form-control" type="text" name="motscles" />
                                    Cat�gorie : <select class="form-control" type="text" name="categorie">
                                                    <option value="" selected>Toutes</option>
                                                    <c:forEach var="c" items="${categories}">
                                                        <option value="${c.nom}">${c.nom}</option>
                                                    </c:forEach>
                                                </select>
                                    Prix :  <input type="text" id="amount" name="prix" readonly style="border:0; color:#f6931f; font-weight:bold;">
                                            <div id="slider-range"></div>
                                </div>
                                <div class="col-md-6">
                                    Ecole : <select class="form-control" type="text" name="ecole">
                                                <option value="" selected>Toutes</option>
                                                <c:forEach var="e" items="${ecoles}">
                                                    <option value="${e.nom}">${e.nom}</option>
                                                </c:forEach>
                                            </select>
                                    Etudiant :  <input class="form-control" type="text" name="etudiant" />
                                    <input type="hidden" name="typ" value="1" /> <!-- 1 correspond aux ventes -->
                                </div>  
                            </div>
                            <br>
                            <button class="btn btn-success" type="submit" value="filtrerAnnonces" name="action" style="float:right;">Chercher</button>
                        </form>
                    </div>
                    <br>
                    <div class="container">
                        <ul class="list-group">
                            <c:forEach var="a" items="${annonces}">
                                <li class="list-group-item">
                                    <div class="annonce row" style="position: relative;">
                                        <c:if test="${sessionScope.PRIVILEGE == 'admin'}">
                                            <a class="outil-link suppr on-element" type="submit" data-toggle="modal" data-target="#modalSupprAnnc${a.id}"><span class="glyphicon glyphicon-remove"></span></a>
                                            <div class="modal fade" id="modalSupprAnnc${a.id}" role="dialog">
                                              <div class="modal-dialog">
                                                <div class="modal-content">
                                                    Etes-vous certain de vouloir supprimer cette annonce ?
                                                    <form action="Admin" method="post">
                                                        <input type="hidden" value="${a.id}" name="id" />
                                                        <button type="submit" value="supprimerAnnonce" name="action">Confirmer</button>
                                                        <hr>
                                                        <a href="Accueil">Annuler</a>
                                                    </form>
                                                </div>
                                              </div>
                                            </div>
                                        </c:if>
                                        <div class="couleurAnnonce col-md-1"></div>
                                        <div class="infoEtudiant col-md-3">
                                            <a href="Profil?user=${a.auteur.pseudo}">
                                                <c:choose>
                                                    <c:when test="${a.auteur.photo != null}">
                                                        <img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="resources/default_profile.jpg" class="img-rounded photoEtudiant">
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <p>${a.auteur.prenom} ${a.auteur.nom}</p>
                                            <p>${a.auteur.ecole.nom}</p>
                                        </div>
                                        <div class="infoProduit col-md-4">
                                            <a href="Annonce?id=${a.id}"><p>${a.titre}</p></a>
                                            <p>${a.categorie.nom}</p>
                                            <p>Date ajout : <fmt:formatDate type="both" value="${a.dateDepot}" /></p>
                                            <p>Date fin : <fmt:formatDate type="date" value="${a.dateFin}" /></p>
                                        </div>
                                        <div class="prixProduit col-md-2">
                                            <p>${a.prix} �</p>
                                        </div>
                                        <div class="photosProduit col-md-2">
                                            <c:choose>
                                                <c:when test="${fn:length(a.photos) > 0}">
                                                    <p><img src="Image/produit/${a.photos[0].id}" class="img-rounded photoProduit"/></p>
                                                    <span class="iconPhoto">
                                                        <img src="resources/camera.png" class="icon"/>
                                                        <span class="nombrePhotos">
                                                            ${fn:length(a.photos)}
                                                        </span>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <p><img src="resources/no_foto.jpg" class="img-rounded photoProduit"></p>
                                                </c:otherwise>
                                            </c:choose>                                    
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>
