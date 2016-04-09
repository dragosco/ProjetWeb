<%-- 
    Document   : depotAnnonce
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
                <div class="col-md-6" >
                    <form action="Annonce" method="post" enctype="multipart/form-data">
                        <input class="form-control" type="text" name="titre" placeholder="Titre" required />
                        <select class="form-control" type="text" name="categorie" placeholder="Catégorie" required>
                            <c:forEach var="c" items="${requestScope.categories}">
                                <option>${c.nom}</option>
                            </c:forEach>
                        </select>
                        <input class="form-control" type="number" step="0.1" name="prix" min=0 placeholder="Prix" required />
                        <input class="form-control" type="file" name="files[]" placeholder="Image" id="files" multiple />
                        <div id="dropAreaAnnonce">Drop files here</div>
                        <input class="form-control" type="date" name="dateFin" placeholder="Date d'exp" required/>
                        <textarea class="form-control" name="description">Décrivez le produit</textarea>
                        <button type="submit" value="creerAnnonce" name="action">Ajouter annonce</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <output id="previewImages"></output>
                </div>
            </div>
        </div>
        <script src="js/main.js"></script>
    </body>
</html>

