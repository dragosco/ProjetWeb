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
        
        <div class="container">
            <div class="main">
                <c:if test="${param.user == sessionScope.USER}">

                        <c:if test="${param.voir == null}">
                            <div class="header">
                                <h3>Votre profil</h3>
                            </div>
                            <jsp:include page="profilEdit.jsp" />
                        </c:if>

                        <c:if test="${param.voir == 'annonces'}">
                            <div class="header">
                                <h3>Vos annonces</h3>
                            </div>
                            <div class="contenu contenu-full">
                                <div style="padding: 10px; font-size: 18px; color: #00585F; text-align: left;">
                                    <span class="glyphicon glyphicon-info-sign"></span>
                                    Utiliser les pictogrammes en haut à droite pour visualiser, éditer ou supprimer une annonce.
                                </div>
                                
                                <jsp:include page="sesAnnoncesEdit.jsp" />
                            </div>
                        </c:if>


                </c:if>

                <c:if test="${param.user != sessionScope.USER}">
                    <div class="header">
                        <h3>Profil</h3>
                    </div>
                    <jsp:include page="profilView.jsp" />
                </c:if>
            </div>
        </div>
        
        <jsp:include page='footer.jsp'/>
    </body>
</html>


