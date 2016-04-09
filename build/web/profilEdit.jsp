<div class="container">
    <div class="row">
        <div class="col-md-2">
            <h2>Profil</h2>
            <br>
            <img src="Image/auteur/${profil.id}" class="img-rounded photoEtudiant">
            <a href="#" data-toggle="popover" title="Changer votre mot de passe" data-content='
                <form action="Compte" method="post" enctype="multipart/form-data">
                    <input type="file" name="nouvProfilePic" id="inputNouvPhotoProfil">
                    <button type="submit" value="changePhoto" name="action">Valider</button>
                </form>
               ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
            </a>
        </div>
            
        <div class="col-md-10">
            <div class="row">
                <h2>${profil.pseudo}</h2>
                <br>
                <span>Mot de passe : </span>${profil.motDePasse}
                    <a href="#" data-toggle="popover" title="Changer votre mot de passe" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="motDePasse" placeholder="Nouveau mot de passe" />
                            <button type="submit" value="changeMotDePasse" name="action">Valider</button>
                        </form>
                       ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                    </a>
                <br>
                <br>    
                <span>Nom : </span>${profil.nom}
                    <a href="#" data-toggle="popover" title="Changer votre nom" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="nom" placeholder="Nouveau nom" />
                            <button type="submit" value="changeNom" name="action">Valider</button>
                        </form>
                        ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                    </a>
                <br>    
                <br>
                <span>Prenom : </span>${profil.prenom}
                    <a href="#" data-toggle="popover" title="Changer votre prenom" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="prenom" placeholder="Nouveau prenom" />
                            <button type="submit" value="changePrenom" name="action">Valider</button>
                        </form>
                        ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                    </a>
                <br>    
                <br>
                <span>Ecole : </span>${profil.ecole}
                    <a href="#" data-toggle="popover" title="Changer votre école" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="ecole" placeholder="Nouvelle école" />
                            <button type="submit" value="changeEcole" name="action">Valider</button>
                        </form>
                        ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                    </a>
                <br>    
                <br>    
                <span>Mail : </span>${profil.mail}
                    <a href="#" data-toggle="popover" title="Changer votre adresse e-mail" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="mail" placeholder="Nouvelle adresse e-mail" />
                            <button type="submit" value="changeMail" name="action">Valider</button>
                        </form>
                        ' data-html='true'><span class="glyphicon glyphicon-pencil"></span>
                    </a>
                <br>    
                <br>    
                <span>Téléphone : </span>${profil.tel}
                    <a href="#" data-toggle="popover" title="Changer votre n° de téléphone" data-content='
                        <form action="Profil" method="post">
                            <input class="form-control" type="text" name="tel" placeholder="Nouveau n°" />
                            <button type="submit" value="changeTel" name="action">Valider</button>
                        </form>
                       ' data-html='true'><span class="glyphicon glyphicon-pencil"></span></a>
                <br>    
                <br>
            </div>
        </div>
    </div>
</div>