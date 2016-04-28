<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row flex">
    <div class="contenu contenu-profil col-md-5">
        <img src="Image/auteur/${profil.id}" class="img-circle photoEtudiant-profil">
        <div id="photoEdit">
            <a class="outil-link edit" type="submit" data-toggle="modal" data-target="#modalEdit${u.pseudo}"><span class="glyphicon glyphicon-camera" id="cameraIcon"></span></a>
        </div>
        <div class="modal fade" id="modalEdit${u.pseudo}" role="dialog">
          <div class="modal-dialog">
            <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
            <div class="modal-content">
                <h4 style="color: #00585F;">Changer votre photo de profil</h4>
                <img class="img-thumbnail" id="previewNouvPhotoProfil" src="Image/auteur/${profil.id}" alt="Ta photo de profil"/>
                <form action="Compte" method="post" enctype="multipart/form-data">
                    <div class="fileinput fileinput-new" data-provides="fileinput" style="width:100%; margin-bottom: 40px;">
                        <span class="btn btn-info btn-file" style="width: 50%;"><span class="fileinput-new">Charger une image...</span><span class="fileinput-exists">Change</span>
                            <input id="inputNouvPhotoProfil" type="file" name="nouvProfilePic" accept="image/*" />
                        </span>
                    </div>
                    
                    <button class="btn btn-success" type="submit" value="changePhoto" name="action">Valider le changement</button>
                </form>
            </div>
          </div>
        </div>
    </div>

    <div class="contenu contenu-profil col-md-7">
        
            <h2>${profil.pseudo} <span class="text-aside">(${profil.prenom} ${profil.nom})</span></h2>
            <hr>
            <table class="table-details-user">
                <tr>
                    <td><span class="glyphicon glyphicon-education"></span></td>
                    <td>${profil.ecole.nom}</td>
                </tr>
                <tr>
                    <td><span class="glyphicon glyphicon-earphone"></span></td>
                    <td>${profil.tel}</td>
                </tr>
                <tr>
                    <td><span class="glyphicon glyphicon-envelope"></span></td>
                    <td>${profil.mail}</td>
                </tr>
            </table>
            <hr>
            <a href="#" class="link edit" data-toggle="popover" data-trigger="focus" title="Changer votre mot de passe" data-content='
                <form action="Profil" method="post" style="padding-top:10px; padding-bottom:10px;">
                    <div class="input-group">
                        <input class="form-control" type="text" name="motDePasse" placeholder="Nouveau mot de passe" />
                        <span class="input-group-btn">
                            <button class="btn btn-success pull-right" type="submit" value="changeMotDePasse" name="action">Valider</button>
                        </span>
                    </div>
                </form>
               ' data-html='true'>Changer votre mot de passe
            </a>
            
            <br>
            <a href="#" class="link edit" data-toggle="popover" data-trigger="focus" title="Editer votre profil" data-content='
                <form action="Profil" method="post">
                    <div class="input-group">
                        <input class="form-control" type="text" name="nom" placeholder="Nouveau nom" />
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit" value="changeNom" name="action">Valider</button>
                        </span>
                    </div>
                </form>
                <form action="Profil" method="post">
                    <div class="input-group">
                        <input class="form-control" type="text" name="prenom" placeholder="Nouveau prenom" />
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit" value="changePrenom" name="action">Valider</button>
                        </span>
                    </div>
                </form>
                <form action="Profil" method="post">
                    <div class="input-group">
                        <select class="form-control" id="inputEcole" type="text" name="ecole" required>
                            <option selected disabled>Campus PACA</option>
                            <c:forEach var="e" items="${requestScope.allEcoles}">
                                <option value="${e.nom}">${e.nom}</option>
                            </c:forEach>
                        </select>
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit" value="changePrenom" name="action">Valider</button>
                        </span>
                    </div>
                </form>
                <form action="Profil" method="post">
                    <div class="input-group">
                        <input class="form-control" type="text" name="mail" placeholder="Nouvelle adresse e-mail" />
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit" value="changeMail" name="action">Valider</button>
                        </span>
                    </div>
                </form>
                <form action="Profil" method="post">
                    <div class="input-group">
                        <input class="form-control" type="text" name="tel" placeholder="Nouveau n°" />
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit" value="changeTel" name="action">Valider</button>
                        </span>
                    </div>
                </form>
               ' data-html='true'>Editer votre profil
            </a>
            <br>
            <a href="#" class="link edit">Supprimer votre compte</a>
            
    </div>
</div>