<%-- 
    Document   : index
    Created on : 24 mars 2016, 14:50:35
    Author     : Dragos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<!-- Ne pas oublier cette ligne sinon tous les tags de la JSTL seront ignorés ! -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <div>
            <form class="functionalityBlock" id="testUsers" action="ProjetWebServlet" method="post">
                <input type="hidden" name="action" value="creerUtilisateursDeTest"/>
                <button type="submit" value="Test" name="submit">Test</button>
            </form>
        </div>
        
    </body>
</html>
