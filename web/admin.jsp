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
            <script src="js/affichages-ajax.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        
        <div class="container">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#gestionUtilisateursContainer">Gestion des utilisateurs</a></li>
                <li><a data-toggle="tab" href="#gestionPhotosContainer">Gestion des photos</a></li>
                <li><a data-toggle="tab" href="#gestionCategoriesContainer">Gestion des catégories</a></li>
            </ul>

            
            <div class="tab-content">
                <!-- GESTIONNAIRE D'UTILISATEURS -->
                <div class="tab-pane fade in active" id="gestionUtilisateursContainer">
                    <div class="row">
                        <input type="hidden" id="totalUsers" value="${requestScope.totalUsers}" />
                        <div class="container">Afficher <input type="number" min="0" step="5" id="nParPage" style="width: 80px;"/> par page</div>
                        
                        <div class="table-responsive container">
                            <table class="table" id="userTable">
                                <tr>
                                    <td></td>
                                    <td>ID</td>
                                    <td>Statut</td>
                                    <td>Pseudo</td>
                                    <td>Nom</td>
                                    <td>Prenom</td>
                                    <td>Etablissement</td>
                                    <td>Telephone</td>
                                    <td>E-mail</td>
                                    <td></td>
                                </tr>
                                <!-- Contenu du tableau chargé dynamiquement en ajax -->
                            </table>
                        </div>
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

                <!-- GESTIONNAIRE DE PHOTOS -->
                <div class="tab-pane fade" id="gestionPhotosContainer">
                    <div class="container">Afficher <input type="number" min="0" step="5" id="nPhotosParPage" style="width: 80px;"/> par page</div>
                    <div class="container" id="photosContainer"></div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a class="btn btn-info" id="startButtonPhotos"><span class="glyphicon glyphicon-triangle-left"></span><span class="glyphicon glyphicon-triangle-left"></span></a></li> 
                            <li><a class="btn btn-info" id="previewButtonPhotos"><span class="glyphicon glyphicon-triangle-left"></span></a></li>
                        </ul>
                        <ul class="pagination">
                            <li><a class="btn btn-info" id="nextButtonPhotos"><span class="glyphicon glyphicon-triangle-right"></span></a></li> 
                            <li><a class="btn btn-info" id="endButtonPhotos"><span class="glyphicon glyphicon-triangle-right"></span><span class="glyphicon glyphicon-triangle-right"></span></a></li> 
                        </ul>
                    </div>
                    
                    <div class="container">Afficher <input type="number" min="0" step="5" id="nPhotosProfilParPage" style="width: 80px;"/> par page</div>
                    <div class="container" id="photosProfilContainer"></div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a class="btn btn-info" id="startButtonPhotosProfil"><span class="glyphicon glyphicon-triangle-left"></span><span class="glyphicon glyphicon-triangle-left"></span></a></li> 
                            <li><a class="btn btn-info" id="previewButtonPhotosProfil"><span class="glyphicon glyphicon-triangle-left"></span></a></li>
                        </ul>
                        <ul class="pagination">
                            <li><a class="btn btn-info" id="nextButtonPhotosProfil"><span class="glyphicon glyphicon-triangle-right"></span></a></li> 
                            <li><a class="btn btn-info" id="endButtonPhotosProfil"><span class="glyphicon glyphicon-triangle-right"></span><span class="glyphicon glyphicon-triangle-right"></span></a></li> 
                        </ul>
                    </div>
                </div>

                <!-- GESTIONNAIRE DE CATEGORIES -->
                <div class="tab-pane fade" id="gestionCategoriesContainer">
                    <form action="Admin" method="post">
                        <div class="input-group">
                            <input class="form-control" type="text" name="titre" placeholder="Ajouter une catégorie..." />
                            <span class="input-group-btn">
                                <button class="btn btn-success" type="submit" value="creerCategorie" name="action">Créer la catégorie</button>
                            </span>
                        </div>
                    </form>
                    <ul class="list-group list-inline">
                        <c:forEach var="c" items="${requestScope.allCategories}">
                            <li class="list-group-item" style="width:19.6%;">
                                ${c.nom} 
                                <a class="outil-link suppr on-element" type="submit" data-toggle="modal" data-target="#modalSupprCateg${c.id}"><span class="glyphicon glyphicon-remove"></span></a>
                                <div class="modal fade" id="modalSupprCateg${c.id}" role="dialog">
                                  <div class="modal-dialog">
                                    <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                                    <div class="modal-content">
                                        Etes-vous certain de vouloir supprimer la catégorie ${c.nom} ?
                                        <form action="Admin" method="post">
                                            <input type="hidden" value="${c.id}" name="id" />
                                            <button type="submit" value="supprimerCategorie" name="action">Confirmer</button>
                                            <hr>
                                            <a href="Admin">Annuler</a>
                                        </form>
                                    </div>
                                  </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>
