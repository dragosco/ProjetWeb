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
        <script src="js/main.js"></script>
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container" style="width: 300px;">
            <form action="Annonce" method="post" enctype="multipart/form-data">
                <input class="form-control" type="text" name="titre" placeholder="Titre" required/>
                <input class="form-control" type="text" name="categorie" placeholder="Catégorie" required/>
                <input class="form-control" type="number" name="prix" placeholder="Prix" required/>
                <input class="form-control" type="text" name="description" placeholder="Description" required/>
                <input class="form-control" type="file" name="file" placeholder="Image" accept="image/*" />
                <input class="form-control" type="date" name="dateFin" placeholder="Date d'exp" required/>
                <input type="hidden" name="action" value="creerOffre"/>
                <button type="submit" value="addoffer" name="submit">Ajouter offre</button>
            </form> 
        </div>
        
    </body>
</html>

