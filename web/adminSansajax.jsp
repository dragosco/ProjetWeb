<%-- 
    Document   : adminSansajax
    Created on : 30 avr. 2016, 17:13:45
    Author     : cojoc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:forEach var="u" items="${requestScope.allUsers}">
    <tr>
        <td>
            <c:if test="${u.photo == null}">
                <img class="img-rounded photoEtudiant" src="resources/default_profile.jpg">
            </c:if>
            <c:if test="${u.photo != null}">
                <img class="img-rounded photoEtudiant" src="Image/auteur/${u.id}">
            </c:if>
        </td>
        <td>${u.id}</td>
        <td>${u.privilege}</td>
        <td><a href="Profil?user=${u.pseudo}">${u.pseudo}</a></td>
        <td>${u.nom}</td>
        <td>${u.prenom}</td>
        <td>${u.ecole.nom}</td>
        <td>${u.tel}</td>
        <td>${u.mail}</td>
        <td>
            <a class="outil-link edit" type="submit" data-toggle="modal" data-target="#modalPriv${u.pseudo}"><span class="glyphicon glyphicon-pencil"></span></a>
            <div class="modal fade" id="modalPriv${u.pseudo}" role="dialog">
              <div class="modal-dialog">
                <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>  
                <div class="modal-content">
                    Changer les droits de ${u.pseudo}
                    <form action="Admin" method="post">
                        <select name="privilege">
                            <option value="user">user</option>
                            <option vlaue="admin">admin</option>
                        </select>
                        <input type="hidden" value="${u.pseudo}" name="pseudo" />
                        <button type="submit" value="changePrivilege" name="action">Confirmer</button>
                        <hr>
                        <a href="Admin">Annuler</a>
                    </form>
                </div>
              </div>
            </div>

            <a class="outil-link suppr" type="submit" data-toggle="modal" data-target="#modalSuppr${u.pseudo}"><span class="glyphicon glyphicon-remove"></span></a>
            <div class="modal fade" id="modalSuppr${u.pseudo}" role="dialog">
                <div class="modal-dialog">
                    <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>
                    <div class="modal-content">
                        Etes-vous certain de vouloir supprimer l'utilisateur ${u.pseudo} ?
                        <form action="Admin" method="post">
                            <input type="hidden" value="${u.id}" name="id" />
                            <button type="submit" value="supprimerUtilisateur" name="action">Confirmer</button>
                            <hr>
                            <a href="Admin">Annuler</a>
                        </form>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</c:forEach>
