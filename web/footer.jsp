<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<footer class="footer" style="">
    <div class="container">
        <nav><a class="edit" href="Accueil">Accueil</a> | <a class="edit" href="Annonce">Déposer une annonce</a> 
            <c:if test="${empty USER}">| <a class="edit" href="Compte">Créer un compte</a></c:if>
            <c:if test="${not empty USER}">| <a class="edit" href="Profil">Accéder à votre profil</a> | <a class="edit" href="Profil">Accéder à vos annonces</a></c:if>
        </nav>
            <br>
        © 2016 etumercatus | Site réalisé par Thais Mota dos Santos et Dragos Cojocaru
        
    </div>
</footer>
