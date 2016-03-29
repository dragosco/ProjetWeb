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
        
        <c:if test="${param.user == sessionScope.USER}">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <h2>Profil</h2>
                        <br>
                        <img src="" alt="photo de profil" style="width: 100px; height: 100px; border: 1px solid black;">
                    </div>
                    <div class="col-md-10">
                        <div class="row">
                            <h2>${PROFIL.pseudo}</h2>
                            <br>
                            <span>Mot de passe : </span>${PROFIL.motDePasse}
                                <a href="#" data-toggle="popover" title="Changer votre mot de passe" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="motDePasse" placeholder="Nouveau mot de passe" />
                                        <input type="hidden" name="action" value="changeMotDePasse"/>
                                        <button type="submit" value="changeMDP" name="submit">Valider</button>
                                    </form>
                                   ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <br>
                            <br>    
                            <span>Nom : </span>${PROFIL.nom}
                                <a href="#" data-toggle="popover" title="Changer votre nom" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="nom" placeholder="Nouveau nom" />
                                        <input type="hidden" name="action" value="changeNom"/>
                                        <button type="submit" value="changeNom" name="submit">Valider</button>
                                    </form>
                                    ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <br>    
                            <br>
                            <span>Prenom : </span>${PROFIL.prenom}
                                <a href="#" data-toggle="popover" title="Changer votre prenom" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="prenom" placeholder="Nouveau prenom" />
                                        <input type="hidden" name="action" value="changePrenom"/>
                                        <button type="submit" value="changePrenom" name="submit">Valider</button>
                                    </form>
                                    ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <br>    
                            <br>
                            <span>Ecole : </span>${PROFIL.ecole}
                                <a href="#" data-toggle="popover" title="Changer votre école" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="ecole" placeholder="Nouvelle école" />
                                        <input type="hidden" name="action" value="changeEcole"/>
                                        <button type="submit" value="changeEcole" name="submit">Valider</button>
                                    </form>
                                    ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <br>    
                            <br>    
                            <span>Mail : </span>${PROFIL.mail}
                                <a href="#" data-toggle="popover" title="Changer votre adresse e-mail" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="mail" placeholder="Nouvelle adresse e-mail" />
                                        <input type="hidden" name="action" value="changeMail"/>
                                        <button type="submit" value="changeMail" name="submit">Valider</button>
                                    </form>
                                    ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <br>    
                            <br>    
                            <span>Téléphone : </span>${PROFIL.tel}
                                <a href="#" data-toggle="popover" title="Changer votre n° de téléphone" data-content='
                                    <form action="Profil" method="post">
                                        <input class="form-control" type="text" name="tel" placeholder="Nouveau n°" />
                                        <input type="hidden" name="action" value="changeTel"/>
                                        <button type="submit" value="changeTel" name="submit">Valider</button>
                                    </form>
                                   ' data-html='true'><span class="glyphicon glyphicon-pencil"></span></a>
                            <br>    
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${param.user != sessionScope.USER}">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                            <h2>Profil</h2>
                            <br>
                            <img src="" alt="photo de profil" style="width: 100px; height: 100px; border: 1px solid black;">
                    </div>
                    <div class="col-md-10">
                        <div class="row">
                            <h2>${requestScope.viewUser.pseudo}</h2>
                            <br>
                            <span>Nom : </span>${requestScope.viewUser.nom}
                            <br>
                            <span>Prenom : </span>${requestScope.viewUser.prenom}
                            <br>
                            <span>Mail : </span>${requestScope.viewUser.mail}
                            <br>
                            <span>Tel : </span>${requestScope.viewUser.tel}
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </body>
</html>


