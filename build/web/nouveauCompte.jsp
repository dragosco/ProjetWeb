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
            <form action="Login" method="post">
                Nom :
                <input class="form-control" type="text" name="nom" required/>
                
                Prenom :
                <input class="form-control" type="text" name="prenom" required/>
                
                Pseudo :
                <input class="form-control" type="text" name="pseudo" required/>
                
                Mot de passe :
                <input class="form-control" type="text" name="motDePasse" required/>
                
                Vérification mot de passe :
                <input class="form-control" type="text" name="verifMotDePasse" required/>
                
                Etablissement :
                <input class="form-control" type="text" name="ecole" requierd/>
                
                Adresse e-mail :
                <input class="form-control" type="text" name="mail" requierd/>
                
                Téléphone :
                <input class="form-control" type="text" name="tel" requierd/>
                
<!--                <input class="form-control" type="file" name="file" placeholder="Image" accept="image/*" />-->
                <button type="submit" value="creerNouveauCompte" name="action">Envoyer</button>
            </form> 
        </div>
        
        
    </body>
</html>
