<%-- 
    Document   : accueil
    Created on : 27/03/2016, 18:44:27
    Author     : thais, dragos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<main>
    <section>        
        <p>entrou</p>
        <p>${requestScope['offres']} e nulo</p>
        <ul class="list-group">
            <c:forEach var="o" items="${requestScope['offres']}">
                <li class="list-group-item">
                    <div class="annonce">
                        <div class="couleurAnnonce col-md-1"></div>
                        <div class="infoEtudiant col-md-2">
                            <a href="#"><img src="/home/thais/Imagens/eu.jpg" class="img-rounded photoEtudiant"></a>
                            <p>${o.utilisateur.nom}</p>
                            <p>${o.utilisateur.ecole}</p>
                        </div>
                        <div class="infoProduit col-md-4">
                            <p>${o.titre}</p>
                            <p>${o.categorie}</p>
                            <p>${o.prix}</p>
                            <p>Date</p>
                        </div>
                        <div class="photosProduit col-md-4">
                            <a href="#"><img src="/home/thais/Imagens/FestivalCannes/DSCN76841.jpg" class="img-rounded"></a>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </section>
</main>

<!--<table class="table">
    <tbody>
      <tr>
        <td>
            
        </td>
      </tr>
    </tbody>
    
</table>-->