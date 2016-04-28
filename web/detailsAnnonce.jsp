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
            <h4>${annonce.titre}</h4>
            <section class="carousel">
                <img src="Image/produit/${annonce.photos[0].id}" class="img-rounded photoDetailProduit"/>
            </section>
            <section class="properties">
                <p>${annonce.dateDepot}</p>
                <p><a href="Profil?user=${annonce.auteur.pseudo}">${annonce.auteur.prenom} ${annonce.auteur.nom}</a></p>
                <p>Prix : ${annonce.prix}</p>
                <p>Ecole : ${annonce.auteur.ecole.nom}</p>
                <p>Description :</p>
                <p>${annonce.description}</p>
            </section>
            
            
        </div>
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>

