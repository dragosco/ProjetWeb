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
            <a class="navbar-brand" href="#"><span class="logo"><span class="etu">etu</span>mercatus</span></a>
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
                        <button type="button" class="btn btn-info btn-lg navbar-btn" data-toggle="modal" data-target="#modalConnection">Se connecter</button>
                        <div class="modal fade" id="modalConnection" role="dialog">
                            <div class="modal-dialog">
                                <button type="button" class="close dismiss-button" data-dismiss="modal">&times;</button>  
                                <img src="resources/blason-pa.png" id="logoPACA">
                                <div class="modal-content" id="modalConnection-content">

                                    <span class="logo"><span class="etu">etu</span>mercatus</span>
                                    <p>Votre site d'annonces étudiantes de la région Provence Alpes Côtes d'Azur</p>

                                    <form action="Login" method="post" id="loginForm">
                                        <div class="form-group has-feedback">
                                            <input class="form-control" id="seConnecterPseudo" type="text" name="pseudo" placeholder="Pseudo" required/>
                                            <i class="glyphicon glyphicon-user form-control-feedback"></i>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <input class="form-control" id="seConnecterPass" type="password" name="motDePasse" placeholder="Mot de passe" required/>
                                            <i class="glyphicon glyphicon-lock form-control-feedback"></i>
                                        </div>
                                        
                                        <button class="btn btn-info btn-block btn-lg" id="seConnecterButton" type="submit" value="authentification" name="action">Me connecter</button>
                                    </form>
                                    
                                    <hr>
                                    <a href="Compte">Créer un compte</a>
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