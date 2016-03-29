<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-default">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
        <a class="navbar-brand" href="#"><span style="color: lightseagreen">etu</span>mercatus</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">

        <li><a href="Accueil">Accueil</a></li>
        <li><a href="Annonce">Déposer une annonce</a></li>
        
      </ul>
        <c:if test="${sessionScope.USER == null}">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Se connecter</button>

                    <!-- Modal -->
                    <div class="modal fade" id="myModal" role="dialog" style="margin-top: 200px;">
                      <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form action="Login" method="post">
                                <input class="form-control" type="text" name="pseudo" placeholder="Username" required/>
                                <input class="form-control" type="password" name="motDePasse" placeholder="Password" required/>
                                <input type="hidden" name="action" value="authentification"/>
                                <button type="submit" value="login" name="submit">Me connecter</button>
                                <hr>
                                <a href="nouveauCompte.jsp">Créer un compte</a>
                                
                            </form> 
                        </div>

                      </div>
                    </div>
                    
                </li>
            </ul>
        </c:if>
        
        <c:if test="${sessionScope.USER != null}">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-user"></span> Mon compte <span class="caret"></span>
                    </a>
                  <ul class="dropdown-menu">
                    <li><a href="Profil?user=${sessionScope.USER}">Mon profil</a></li>
                    <li><a href="#">Mes annonces</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="Logout">Se déconnecter</a></li>
                  </ul>
                </li>
             </ul>
        </c:if>
      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>