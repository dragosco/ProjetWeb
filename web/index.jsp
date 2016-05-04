<%-- 
    Document   : index
    Created on : 24 mars 2016, 14:50:35
    Authors     : Thais, Dragos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">-->
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
                  $("#amount").val(ui.values[0] + "€" + " - " + ui.values[1] + "€");
                }
              });
              $("#amount").val($("#slider-range").slider("values", 0) + "€" +
                " - " + $("#slider-range").slider("values", 1) + "€" );
            });
        </script>
        <script src="js/accueil.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container">
            <c:if test="${param.message == 'compteOK'}">
                <div class="alert alert-success" id="compteOK" role="alert">
                    Félicitations, votre compte a été créé avec succès <span class="glyphicon glyphicon-thumbs-up" style="width:30px;"></span> Vous pouvez vous connecter
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
                                Il faut être connecté pour déposer une annonce
                                <br>
                                Connectez-vous ou créez un <a href="Compte">nouveau compte</a>
                            </span>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        
        <div class="container">
<!--            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#ventesContainer">Ventes</a></li>
                <li><a data-toggle="tab" href="#recherchesContainer">Recherches</a></li>
            </ul>-->
            
            <div class="tab-content">
                <!-- VENTES -->
                <div class="tab-pane fade in active" id="ventesContainer">
                    <div class="row">
                        <div class="container">
                            <form action="Accueil" method="get">
                                <div class="row">
                                    <div class="col-md-6">
                                        Mots clés : <input class="form-control" type="text" id="motscles" name="motscles" />
                                        Catégorie : <select class="form-control" type="text" id="categorie" name="categorie">
                                                        <option value="" selected>Toutes</option>
                                                        <c:forEach var="c" items="${categories}">
                                                            <option value="${c.nom}">${c.nom}</option>
                                                        </c:forEach>
                                                    </select>
                                        Prix :  <input type="text" id="amount" name="prix" readonly style="border:0; color:#f6931f; font-weight:bold;">
                                                <div id="slider-range"></div>
                                    </div>
                                    <div class="col-md-6">
                                        Ecole : <select class="form-control" type="text" id="ecole" name="ecole">
                                                    <option value="" selected>Toutes</option>
                                                    <c:forEach var="e" items="${ecoles}">
                                                        <option value="${e.nom}">${e.nom}</option>
                                                    </c:forEach>
                                                </select>
                                        Etudiant :  <input class="form-control" type="text" id="etudiant" name="etudiant" />
    <!--                                    <input type="hidden" name="typ" value="1" />  1 correspond aux ventes -->
                                    </div>  
                                </div>
                                <br>
                                <button class="btn btn-success" type="button" value="filtrerVentes" id="recherche" name="action" style="float:right;">Chercher</button>
                            </form>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="container" style="padding-right: 50px;">
                            <input type="hidden" id="totalVentes" value="0" />
                            <ul class="list-group" id="listeVentes">
                            
                            </ul>
                        </div>
                    </div>
                </div>
<!--                    <button class="btn btn-success" type="button" id="previewButton" name="action" style="float:left;"/>Preview</button>
                    <button class="btn btn-success" type="button" id="nextButton" name="action" style="float:right;"/>Next</button>-->
                <div class="container">
                    <div class="btn-group inline">
                        <button class="btn btn-info" id="startButton"><span class="glyphicon glyphicon-triangle-left"></span><span class="glyphicon glyphicon-triangle-left"></span></button>
                        <button class="btn btn-info" id="previewButton"><span class="glyphicon glyphicon-triangle-left"></span></button>
                    </div>
                    <span class="inline" id="quellePage">String to display after buttons on same line</span> 
                    <div class="btn-group inline">
                        <button class="btn btn-info" id="nextButton"><span class="glyphicon glyphicon-triangle-right"></span></button>
                        <button class="btn btn-info" id="endButton"><span class="glyphicon glyphicon-triangle-right"></span><span class="glyphicon glyphicon-triangle-right"></span></button>
                    </div>
                </div>
            </div>
        </div>       
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>