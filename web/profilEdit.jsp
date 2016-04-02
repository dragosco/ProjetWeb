<div class="container">
    <div class="row">
        <div class="col-md-2">
            <h2>Profil</h2>
            <br>
            <img src="Image/auteur/${profil.id}" class="img-rounded photoEtudiant">
        </div>
        <div class="col-md-10">
            <div class="row">
                <h2>${profil.pseudo}</h2>
                <br>
                <span>Mot de passe : </span>${profil.motDePasse}
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
                <span>Nom : </span>${profil.nom}
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
                <span>Prenom : </span>${profil.prenom}
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
                <span>Ecole : </span>${profil.ecole}
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
                <span>Mail : </span>${profil.mail}
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
                <span>Téléphone : </span>${profil.tel}
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