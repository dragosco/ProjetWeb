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
        
        <c:if test="${param.user == sessionScope.USER}">
            <c:if test="${param.action == null}"><jsp:include page="profilEdit.jsp" /></c:if>
            <c:if test="${param.action == 'afficheAnnonces'}"><jsp:include page="sesAnnoncesEdit.jsp" /></c:if>
        </c:if>
        
        <c:if test="${param.user != sessionScope.USER}">
            <jsp:include page="profilView.jsp" />
        </c:if>
    </body>
</html>


