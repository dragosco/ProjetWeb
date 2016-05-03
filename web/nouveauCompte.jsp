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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jasny-bootstrap.min.css">
        <link rel="stylesheet" href="css/jquery.Jcrop.css" type="text/css" />
        <script src="js/jquery-2.2.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jasny-bootstrap.min.js"></script>
        <script src="js/jquery.Jcrop.js"></script>
        <script src="js/jquery-scripts.js"></script>
                
        
    </head>
    <body>
        <jsp:include page='navbar.jsp'/>
        
        <div class="container" id="nouveau-compte">
            <div class="main">
                <c:if test="${empty param}">
                    <div class="header">
                        <h3>Création de compte</h3>
                    </div>
                    <div class="contenu">
                        <jsp:include page="formNouveauCompte.jsp" />
                    </div>
                </c:if>
                
                <c:if test="${param.message == 'loginKO'}">
                    <div class="row">
                        <div class="col-md-7" style="padding-right: 0;">
                            <div class="header header-left">
                                <h3>Création de compte</h3>
                            </div>
                            <div class="contenu contenu-right">
                                <jsp:include page="formNouveauCompte.jsp" />
                            </div>
                        </div>
                        <div class="col-md-5" style="padding-left: 0;">
                            <div class="header header-right">
                                <h3> Se connecter</h3>
                            </div>
                            <div class="contenu contenu-left">
                                <div class="alert alert-danger" id="echecAuth" role="alert">
                                    Pseudo et/ou mot de passe erroné(s)
                                </div>
                                <form action="Login" method="post" id="loginForm">
                                    <div class="form-group has-feedback">
                                        <input class="form-control" id="seConnecterPseudo" type="text" name="pseudo" placeholder="Pseudo" required/>
                                        <i class="glyphicon glyphicon-user form-control-feedback"></i>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <input class="form-control" id="seConnecterPass" type="password" name="motDePasse" placeholder="Mot de passe" required/>
                                        <i class="glyphicon glyphicon-lock form-control-feedback"></i>
                                    </div>

                                    <button class="btn btn-info btn-block btn-lg" id="seConnecterButton" type="submit" value="authentification" name="action">Me connecter</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div> <!-- main --> 
        </div> <!-- nouveau-compte -->
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>
