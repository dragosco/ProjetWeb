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
            <h4>Gestion des utilisateurs</h4>
            <div class="row">
                <form action="Admin" method="get">
                     à implémenter filtre recherches
                    
                </form>
            </div>
            <br>
            <div class="row">
                <div class="table-responsive"> 
                    <table class="table table-striped">
                        <tr>
                            <td>Photo</td>
                            <td>pseudo</td>
                            <td>Nom</td>
                            <td>Prenom</td>
                            <td>Etablissement</td>
                            <td>Telephone</td>
                            <td>E-mail</td>
                        </tr>
                        <c:forEach var="u" items="${requestScope.allUsers}">
                            <tr>
                                <td><img class="img-rounded photoEtudiant" src="Image/auteur/${u.id}"></td>
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
        
        <div class="container">
            <h4>Gestion des photos</h4>
            <c:forEach var="p" items="${requestScope.allPhotos}">
                <img src="Image/produit/${p.id}" style="width:200px; height: auto;">
            </c:forEach>
        </div>
        
        <div class="container">
            <h4>Gestion des catégories</h4>
            <div class="row">
                <div class="col-md-8">
                    Ajouter une catégorie :
                    <form action="Admin" method="post">
                        <input class="form-control" type="text" name="titre" />
                        <button type="submit" value="creerCategorie" name="action">Créer la catégorie</button>
                    </form>
                    
                    Supprimer une catégorie :
                    <form action="Admin" method="post">
                        <input class="form-control" type="text" name="titre" />
                        <button type="submit" value="supprimerCategorie" name="action">Supprimer la catégorie</button>
                    </form>
                </div>
                <div class="col-md-4">
                    <ul class="list-group">
                        <c:forEach var="c" items="${requestScope.allCategories}">
                            <li class="list-group-item">${c.nom}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            
        </div>
        
    </body>
</html>
