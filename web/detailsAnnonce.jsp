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

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>etumercatus</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery-2.2.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <style>
            .carousel-inner > .item > img,
            .carousel-inner > .item > a > img {
                //width: 70%;
                margin: auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <div class="main">
                <div class="header">
                    <h3>${annonce.titre}</h3>
                </div>
                <div class="contenu">
                    <section class="">
                        <div class="container">
                            <br>
                            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                              <!-- Indicators -->
                              <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel" data-slide-to="1"></li>
                              </ol>

                              <!-- Wrapper for slides -->
                              <div class="carousel-inner" role="listbox">

                                <div class="item active">
                                  <img src="Image/produit/${annonce.photos[0].id}" class="img-rounded photoDetailProduit" alt="Chania">
                                  <div class="carousel-caption">
                                    <h3>Chania</h3>
                                    <p>The atmosphere in Chania has a touch of Florence and Venice.</p>
                                  </div>
                                </div>

                                <div class="item">
                                  <img src="Image/produit/${annonce.photos[0].id}" class="img-rounded photoDetailProduit" alt="Chania">
                                  <div class="carousel-caption">
                                    <h3>Chania</h3>
                                    <p>The atmosphere in Chania has a touch of Florence and Venice.</p>
                                  </div>
                                </div>
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
                        </div>
                    </section>
                    <section class="properties">
                        
                        <p>Mise en ligne le <fmt:formatDate value="${annonce.dateDepot}" pattern="dd MMMMM"/> à <fmt:formatDate value="${annonce.dateDepot}" pattern="HH:mm" /></p>
                        <p><a href="Profil?user=${annonce.auteur.pseudo}">${annonce.auteur.prenom} ${annonce.auteur.nom}</a></p>
                        <p>Prix : ${annonce.prix}</p>
                        <p>Ecole : ${annonce.auteur.ecole.nom}</p>
                        <p>Description :</p>
                        <p>${annonce.description}</p>
                    </section>
                </div>
            </div>
        </div>
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>

