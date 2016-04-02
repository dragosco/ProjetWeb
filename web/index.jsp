<%-- 
    Document   : index
    Created on : 24 mars 2016, 14:50:35
    Authors     : Thais, Dragos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>etumercatus</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery-2.2.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <main>
                <section>
                    <ul class="list-group">
                        <c:forEach var="a" items="${annonces}">
                            <li class="list-group-item">
                                <div class="annonce" style="position: relative;">
                                    <c:if test="${sessionScope.PRIVILEGE == 'admin'}">
                                        <a href="Accueil?action=supprimerAnnonce&id=${a.id}" style="position: absolute; top:0; right:0; z-index:10;"><span class="glyphicon glyphicon-remove"></span></a>
                                    </c:if>
                                    
                                    
                                    <div class="couleurAnnonce col-md-1"></div>
                                    <div class="infoEtudiant col-md-3">
                                        <a href="Profil?user=${a.auteur.pseudo}"><img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant"></a>
                                        <p>${a.auteur.prenom} ${a.auteur.nom}</p>
                                        <p>${a.auteur.ecole}</p>
                                    </div>
                                    <div class="infoProduit col-md-4">
                                        <p>${a.titre}</p>
                                        <p>${a.categorie.nom}</p>
                                        <p>Date</p>
                                    </div>
                                    <div class="prixProduit col-md-2">
                                        <p>${a.prix} €</p>
                                    </div>
                                    <div class="photosProduit col-md-2">
                                        <p><img src="Image/produit/${a.photos[0].id}" class="img-rounded photoProduit"/></p>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </main>
        </div>
    </body>
</html>
