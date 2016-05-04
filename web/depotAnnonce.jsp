<%-- 
    Document   : depotAnnonce
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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jasny-bootstrap.min.css">
        <script src="js/jquery-2.2.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jasny-bootstrap.min.js"></script>
        <script src="js/jquery-scripts.js"></script>
        
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        
        <div class="container">
            <div class="main">
                <form action="Annonce" method="post" enctype="multipart/form-data">
                    <div class="header" style="border-top-right-radius: 10px; border-top-left-radius: 10px;">
                        <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-select btn-left active">
                              <input class="annonce-radio-select" type="radio" name="type" value="1" checked> Je veux vendre
                            </label>
                            <label class="btn btn-select btn-right">
                              <input class="annonce-radio-select" type="radio" name="type" value="0"> Je recherche
                            </label>
                          </div>
                    </div>
                    <div class="contenu">
                        <div class="row">
                            <!-- TITRE -->
                            <div class="form-group col-md-9">
                                <label for="inputTitre">Le titre de votre annonce *</label>
                                <input class="form-control" id="inputTitre" type="text" name="titre" placeholder="Titre" required />
                            </div>
                            
                            <!-- CATEGORIE -->
                            <div class="form-group col-md-3">
                                <label for="selectorCategorie">Catégorie *</label>
                                <select class="form-control" id="selectorCategorie" type="text" name="categorie" placeholder="Catégorie" required>
                                    <c:forEach var="c" items="${requestScope.categories}">
                                        <option value="${c.id}">${c.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- DATE DE VALIDITE -->
                            <div class="form-group col-md-6">
                                <label for="dateValidite">Date de fin de validité (optionnelle) </label>
                                <input class="form-control" id="dateValidite" type="date" name="dateFin" placeholder="Date d'exp"/>
                            </div>
                            
                            <!-- PRIX -->
                            <div class="form-group col-md-6">
                                <label for="prix">Prix (en euros) *</label>
                                <input class="form-control" id="prix" type="number" step="0.1" name="prix" min=0 placeholder="Prix" required /> 
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- PHOTOS -->
                            <div class="form-group col-md-12">
                                <label for="inputTitre">Sélectionner une ou plusieurs images représentatives *</label>
                                <div class="fileinput fileinput-new" data-provides="fileinput" style="width:100%;">
                                    <span class="btn btn-info btn-file blue-paca" style="width: 100%;"><span class="fileinput-new">Charger une image...</span><span class="fileinput-exists">Change</span>
                                        <input class="form-control blue-paca" type="file" name="files[]" accept="image/*" placeholder="Image" id="files" multiple />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <!-- DROP AREA -->
                            <div class="form-group col-md-12">
                                <div id="dropAreaAnnonce">Drop files here</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <output id="previewImages"></output>
                            </div>
                        </div>
                        <div class="row">
                            <!-- DESCRIPTION -->
                            <div class="form-group col-md-12">
                                <label for="descriptionProduit">Description de votre produit</label>
                                <textarea class="form-control" id="descriptionProduit" name="description" placeholder="Maximum 255 caractères" maxlength="254"></textarea>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="form-group col-md-12">
                                <button class="btn btn-info pull-right" value="creerAnnonce" name="action">Publier annonce</button>
                            </div>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
        <script src="js/main.js"></script>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>

