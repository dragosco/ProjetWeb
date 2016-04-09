<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#barreDeNav" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
            <a class="navbar-brand" href="#"><span style="color: lightseagreen">etu</span>mercatus</a>
        </div>

        <div class="collapse navbar-collapse" id="barreDeNav">
            <ul class="nav navbar-nav">
                <li><a href="Accueil">Accueil</a></li>
                <li><a href="Annonce">Déposer une annonce</a></li>
                <c:if test="${sessionScope.PRIVILEGE == 'admin'}">
                    <li><a href="Admin">ADMINISTRATION</a></li>
                </c:if>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${sessionScope.USER == null}">
                    <li>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modalConnection">Se connecter</button>
                        <div class="modal fade" id="modalConnection" role="dialog">
                          <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="Login" method="post">
                                    <input class="form-control" type="text" name="pseudo" placeholder="Username" required/>
                                    <input class="form-control" type="password" name="motDePasse" placeholder="Password" required/>
                                    <button type="submit" value="authentification" name="action">Me connecter</button>
                                    <hr>
                                    <a href="Compte">Créer un compte</a>
                                </form>
                            </div>
                          </div>
                        </div>
                    </li>
                </c:if>

                <c:if test="${sessionScope.USER != null}">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-user"></span> Mon compte <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="Profil?user=${sessionScope.USER}">Mon profil</a></li>
                            <li><a href="Profil?user=${sessionScope.USER}&action=afficheAnnonces">Mes annonces</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="Logout">Se déconnecter</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>