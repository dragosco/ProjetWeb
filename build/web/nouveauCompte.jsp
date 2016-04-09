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
            <div class="row">
                <div class="col-md-6">
                    <form action="Compte" method="post" enctype="multipart/form-data">
                        Nom :
                        <input class="form-control" type="text" name="nom" required/>

                        Prenom :
                        <input class="form-control" type="text" name="prenom" required/>

                        Pseudo* :
                        <input class="form-control" type="text" name="pseudo" required/>

                        Mot de passe* :
                        <input class="form-control" type="text" name="motDePasse" required/>

                        Vérification mot de passe* :
                        <input class="form-control" type="text" name="verifMotDePasse" required/>

                        Etablissement* :
                        <input class="form-control" type="text" name="ecole" requierd/>

                        Adresse e-mail* :
                        <input class="form-control" type="text" name="mail" requierd/>

                        Téléphone* :
                        <input class="form-control" type="text" name="tel" requierd/>
                        
                        Photo de profil :
                        <input class="form-control" type="file" name="profilePic" placeholder="Image" id="inputPhotoProfil"/>
                        
                        <img id="previewPhotoProfil" src="#" alt="Ta photo de profil" style="height: 100px; width: auto; border:1px gray dashed;"/>
                        
                        <button type="submit" value="creerNouveauCompte" name="action">Envoyer</button>
                    </form> 
                </div>
                
                <div class="col-md-6">
                    <c:if test="${param.message == 'loginKO'}">
                        <span style="background-color: red; color: black;">Pseudo et/ou mot de passe erroné(s)</span>
                        <form action="Login" method="post">
                            <input class="form-control" type="text" name="pseudo" placeholder="Username" required/>
                            <input class="form-control" type="password" name="motDePasse" placeholder="Password" required/>
                            <button type="submit" value="authentification" name="action">Me connecter</button>
                        </form>
                    </c:if>

                    <c:if test="${param.message == 'compteKO'}">
                        <span style="background-color: red; color: black;">Le pseudo que vous avez choisi existe déjà</span>
                    </c:if>    
                </div>
            </div>
        </div>
        <script src="js/main.js"></script>
    </body>
</html>
