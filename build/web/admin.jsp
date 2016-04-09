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
        <script src="js/main.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <!-- GESTIONNAIRE D'UTILISATEURS -->
        <div class="container"><button class="btn btn-block" id="gestionUtilisateursButton">Gestion des utilisateurs</button></div>
        <div class="container" id="gestionUtilisateursContainer">

            <div class="container">
                <form action="Admin" method="get">
                    <div class="row">
                        <div class="col-md-6">
                            Pseudo : <input class="form-control" type="text" name="pseudo" />
                            Nom : <input class="form-control" type="text" name="nom" />
                        </div>
                        <div class="col-md-6">
                            Ecole : <input class="form-control" type="text" name="ecole" />
                            Order By :  <select class="form-control" type="text" name="orderBy">
                                            <option value="ecole">Ecole</option>
                                            <option value="nom">Nom</option>
                                            <option value="prenom">Prenom</option>
                                            <option value="pseudo">Pseudo</option>
                                            <option value="privilege">Statut</option>
                                        </select>

                        </div>  
                    </div>
                    <br>
                    <button class="btn btn-success" type="submit" value="filtrerUtilisateurs" name="action" style="float:right;">Chercher</button>
                </form>
            </div>
            <br>
            <div class="row">
                <div class="table-responsive container">
                    <table class="table table-striped" id="userTable">
                        <tr>
                            <td></td>
                            <td>Statut</td>
                            <td>Photo</td>
                            <td>Pseudo</td>
                            <td>Nom</td>
                            <td>Prenom</td>
                            <td>Etablissement</td>
                            <td>Telephone</td>
                            <td>E-mail</td>
                            
                        </tr>
                        <c:forEach var="u" items="${requestScope.allUsers}">
                            <tr>
                                <td>
                                    <button class="link-like-button" type="submit" data-toggle="modal" data-target="#modalSuppr${u.pseudo}"><span class="glyphicon glyphicon-remove"></span></button>
                                    <div class="modal fade" id="modalSuppr${u.pseudo}" role="dialog">
                                      <div class="modal-dialog">
                                        <div class="modal-content">
                                            Etes-vous certain de vouloir supprimer l'utilisateur ${u.pseudo} ?
                                            <form action="Admin" method="post">
                                                <input type="hidden" value="${u.pseudo}" name="pseudo" />
                                                <button type="submit" value="supprimerUtilisateur" name="action">Confirmer</button>
                                                <hr>
                                                <a href="Admin">Annuler</a>
                                            </form>
                                        </div>
                                      </div>
                                    </div>
                                </td>
                                <td>${u.privilege}
                                <button class="link-like-button" type="submit" data-toggle="modal" data-target="#modalPriv${u.pseudo}"><span class="glyphicon glyphicon-pencil"></span></button>
                                    <div class="modal fade" id="modalPriv${u.pseudo}" role="dialog">
                                      <div class="modal-dialog">
                                        <div class="modal-content">
                                            Changer les droits de ${u.pseudo}
                                            <form action="Admin" method="post">
                                                <select name="privilege">
                                                    <option value="user">user</option>
                                                    <option vlaue="admin">admin</option>
                                                </select>
                                                <input type="hidden" value="${u.pseudo}" name="pseudo" />
                                                <button type="submit" value="changePrivilege" name="action">Confirmer</button>
                                                <hr>
                                                <a href="Admin">Annuler</a>
                                            </form>
                                        </div>
                                      </div>
                                    </div>
                                </td>
                                <td>
                                    <c:if test="${u.photo == null}">
                                        <img class="img-rounded photoEtudiant" src="resources/default_profile.jpg">
                                    </c:if>
                                    <c:if test="${u.photo != null}">
                                        <img class="img-rounded photoEtudiant" src="Image/auteur/${u.id}">
                                    </c:if>
                                </td>
                                <td><a href="Profil?user=${u.pseudo}">${u.pseudo}</a></td>
                                <td>${u.nom}</td>
                                <td>${u.prenom}</td>
                                <td>${u.ecole}</td>
                                <td>${u.tel}</td>
                                <td>${u.mail}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            
        </div>
        
        <!-- GESTIONNAIRE DE PHOTOS -->
        <div class="container"><button class="btn btn-block" id="gestionPhotosButton">Gestion des photos</button></div>
        <div class="container" id="gestionPhotosContainer">
            
            <div class="row">
                <h5>Photos annonces</h5>
                <c:forEach var="p" items="${requestScope.allPhotos}">
                    <div id="imageWrapper" style="float:left; position:relative;">
                        <img src="Image/produit/${p.id}" style="width:200px; height: auto;">
                        <button class="link-like-button" type="submit" data-toggle="modal" data-target="#modalSupprPhoto${p.id}" style="display:inline-block; float:right; position:absolute; top:0; right:0;"><span class="glyphicon glyphicon-remove"></span></button>
                        <div class="modal fade" id="modalSupprPhoto${p.id}" role="dialog">
                          <div class="modal-dialog">
                            <div class="modal-content">
                                Etes-vous certain de vouloir supprimer cette photo ?
                                <img src="Image/produit/${p.id}" style="width:200px; height: auto;">
                                <form action="Admin" method="post">
                                    <input type="hidden" value="${p.id}" name="id" />
                                    <button type="submit" value="supprimerPhoto" name="action">Confirmer</button>
                                    <hr>
                                    <a href="Admin">Annuler</a>
                                </form>
                            </div>
                          </div>
                        </div>
                    </div>
                    
                </c:forEach>
            </div>
            
            <div class="row">
                <h5>Photos profil</h5>
                <c:forEach var="u" items="${requestScope.allUsers}">
                    <c:if test="${u.photo != null}">
                        <img src="Image/auteur/${u.id}" style="width:150px; height: auto;">
                    </c:if>
                </c:forEach>
            </div>
            
        </div>
        
        <!-- GESTIONNAIRE DE CATEGORIES -->
        <div class="container"><button class="btn btn-block" id="gestionCategoriesButton">Gestion des catégories</button></div>
        <div class="container" id="gestionCategoriesContainer">
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
                        <button class="link-like-button" type="submit" data-toggle="modal" data-target="#modalSupprCateg${c.id}" style="float:right;"><span class="glyphicon glyphicon-remove"></span></button>
                        <div class="modal fade" id="modalSupprCateg${c.id}" role="dialog">
                          <div class="modal-dialog">
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
        <script src="tsorter.min.js" type="text/javascript"></script>
    </body>
</html>
