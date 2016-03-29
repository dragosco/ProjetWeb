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
        <script src="js/jquery-2.2.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <!-- <h1>PAGE D'ACCUEIL (UNDER CONSTRUCTION)</h1> -->            
            <main>
                <section>
                    <ul class="list-group">
                        <c:forEach var="o" items="${offres}">
                            <li class="list-group-item">
                                <div class="annonce">
                                    <div class="couleurAnnonce col-md-1"></div>
                                    <div class="infoEtudiant col-md-3">
                                        <a href="#"><img src="/home/thais/Imagens/eu.jpg" class="img-rounded photoEtudiant"></a>
                                        <p>${o.auteur.prenom} ${o.auteur.nom}</p>
                                        <p>${o.auteur.ecole}</p>
                                    </div>
                                    <div class="infoProduit col-md-4">
                                        <p>${o.titre}</p>
                                        <p>${o.categorie}</p>
                                        <p>Date</p>
                                    </div>
                                    <div class="prixProduit col-md-2">
                                        <p>${o.prix} €</p>
                                    </div>
                                    <div class="photosProduit col-md-2">
                                        <a href="#"><img src="/home/thais/Imagens/FestivalCannes/DSCN76841.jpg" class="img-rounded"></a>
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
