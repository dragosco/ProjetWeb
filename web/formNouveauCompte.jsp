<%-- 
    Document   : formNouveauCompte
    Created on : 13 avr. 2016, 11:22:52
    Author     : Dragos
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<form id="formNouveauCompte" action="Compte" method="post" enctype="multipart/form-data">
    <div class="row">
        <div class="col-md-4">
            <div class="preview-container">
                <img src="resources/default_profile.jpg" class="img-thumbnail previewPhotoProfil" id="target" alt="Votre photo de profil ici" style="width: 100%; height: auto;"/>
            </div>
            <div class="fileinput fileinput-new" data-provides="fileinput" style="width:100%;">
                <span class="btn btn-info btn-file" style="width: 100%;"><span class="fileinput-new">Charger une image...</span><span class="fileinput-exists">Change</span>
                    <input id="inputPhotoProfil" type="file" name="profilePic" accept="image/*" />
                    <input type="hidden" id="x" name="x" />
                    <input type="hidden" id="y" name="y" />
                    <input type="hidden" id="w" name="w" />
                    <input type="hidden" id="h" name="h" />
                    <input type="hidden" id="ratiodivider" name="ratiodivider" />
                </span>
            </div>
        </div>
        <!-- PSEUDO -->
        <div class="form-group col-md-8" id="pseudoDiv">
            <label for="inputPseudo">Pseudo *</label>
            <input class="form-control nouveau-compte-input" id="inputPseudo" type="text" name="pseudo" placeholder="ex. John_2000" required/>
            <div class="alert alert-danger" id="compteKO" role="alert"></div>
        </div>

        <!-- ECOLE -->
        <div class="form-group col-md-8">
            <label for="inputEcole">Etablissement *</label>
            <select class="form-control" id="inputEcole" type="text" name="ecole" required>
                <option selected disabled>Campus PACA</option>
                <c:forEach var="e" items="${requestScope.allEcoles}">
                    <option value="${e.nom}">${e.nom}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="row">
        <!-- NOM -->
        <div class="form-group col-md-6">
            <label for="inputNom">Nom *</label>
            <input class="form-control nouveau-compte-input" id="inputNom" type="text" name="nom" placeholder="ex. Smith" required/>
        </div>
        <!-- PRENOM -->
        <div class="form-group col-md-6">
            <label for="inputPrenom">Prénom *</label>
            <input class="form-control nouveau-compte-input" id="inputPrenom" type="text" name="prenom" placeholder="ex. John" required/>
        </div>
    </div>
    
    <div class="row">
        <!-- MOT DE PASSE -->
        <div class="form-group col-md-12">
            <label for="motDePasse">Mot de passe *</label>
            <input class="form-control nouveau-compte-input" id="motDePasse" type="password" name="motDePasse" placeholder="Au moins 6 caractères dont au moins 1 maj, 1 min et 1 chiffre" required 
                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" 
                   title="Le mot de passe doit contenir au moins un chiffre, un caractère en minuscule et en majuscule, et comprendre minimum 6 caractères." />
        </div>
    </div>
    
    <div class="row">
        <!-- CONFIRME MDP -->
        <div class="form-group col-md-12">
            <label for="verifMotDePasse">Mot de passe (Confirmer) *</label>
            <input class="form-control nouveau-compte-input" id="verifMotDePasse" type="password" name="verifMotDePasse" placeholder="Introduisez à nouveau le mot de passe" required 
                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" />
            <div class="alert alert-danger" id="echecMDP" role="alert"></div>
        </div>
    </div>
    
    <div class="row">
        <!-- E-MAIL -->
        <div class="form-group col-md-7">
            <label for="inputMail">Adresse e-mail *</label>
            <input class="form-control nouveau-compte-input" id="inputMail" type="text" name="mail" placeholder="ex. john2000@truc.fr" requierd/>
        </div>
        
        <!-- TELEPHONE -->
        <div class="form-group col-md-5">
            <label for="inputTel">N° de téléphone *</label>
            <input class="form-control nouveau-compte-input" id="inputTel" type="tel" name="tel" placeholder="ex. 06******** ou +336********" requierd
                   pattern="(?=.*\d).{8,}"
                   title="ex. 06******** ou +336********" />
        </div>
    </div>
    
    <div class="row">
        <div class="form-group col-md-12">
            <input type="checkbox" id="checkConditions" title="Si vous n'acceptez les Termes et Conditions d'utilisation, vous ne pouvez pas créer un compte." required/> J'accepte les <a href="#" data-toggle="modal" data-target="#modalTermesConditions">Termes et Conditions</a> d'utilisation
            <div class="alert alert-danger" id="conditionsKO" role="alert"></div>
            <div class="modal fade" id="modalTermesConditions" role="dialog">
                <div class="modal-dialog">
                    <button type="button" class="close dismiss-button" data-dismiss="modal" style="margin-top:-30px;margin-right: -30px;"><span class="glyphicon glyphicon-remove-circle"></span></button>  

                    <div class="modal-content">
                        <h3>Termes et Conditions d'utilisation du site</h3>
                        <div style="text-align: justify;">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce finibus suscipit sagittis. Morbi condimentum accumsan malesuada. Donec dui sapien, cursus cursus luctus ac, sodales in risus. Morbi nulla diam, lacinia molestie leo nec, sodales iaculis lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tempor consectetur purus, sed sagittis urna facilisis non. Nam mollis neque vitae pulvinar ullamcorper. Vestibulum vel sollicitudin eros, nec sollicitudin est. Morbi eu metus urna. Quisque imperdiet ut urna ac suscipit. Aenean a feugiat massa. Maecenas in feugiat tellus, ut suscipit nunc. Vivamus pretium sapien nisi, non vestibulum metus feugiat ultricies. Mauris suscipit dignissim mi, in aliquet velit condimentum ut. Suspendisse ac nunc tellus.</p>
                            <p>Duis sed nunc finibus, vestibulum dolor non, malesuada arcu. Curabitur non neque imperdiet, molestie justo et, iaculis arcu. Aliquam ut fermentum massa, vitae venenatis arcu. Etiam augue purus, accumsan in orci nec, ultricies sagittis sem. Fusce tincidunt dui non metus lacinia, a placerat nisl imperdiet. Nam congue ultricies dui vel efficitur. Vivamus accumsan tortor id urna molestie placerat. Aliquam vel congue velit. Aliquam sed accumsan purus. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p>
                            <p>Aliquam fermentum arcu orci, quis porta quam eleifend vitae. Donec tristique quam a nulla placerat, ut feugiat dolor aliquet. Integer sit amet nisi ipsum. Donec molestie ornare odio, quis venenatis neque hendrerit quis. Nam lacus nibh, pulvinar id tortor quis, ornare efficitur tellus. Praesent ultricies rhoncus lorem, et auctor lacus mollis sit amet. In mollis mauris non nisl aliquam luctus. Nullam placerat odio sit amet ipsum rutrum, ut accumsan ante mattis. In nec nunc sapien. Mauris at cursus sem, non sodales sem. Cras facilisis finibus nisi quis sagittis. Vivamus aliquam sit amet urna quis consequat.</p>
                            <p>Nam condimentum ligula nulla, vitae laoreet nisl dapibus aliquet. In condimentum et urna vitae laoreet. Integer quis porttitor lacus, at vulputate metus. Praesent faucibus mi vitae condimentum semper. Nam at nisl eget nisi luctus luctus. Etiam non iaculis augue, ultrices malesuada justo. Cras lobortis dolor cursus congue consequat. Quisque dignissim, lacus eu accumsan bibendum, sem magna sagittis nulla, sed elementum nunc sapien vitae ipsum. Sed non sodales turpis. Sed dictum, ligula et vestibulum fringilla, ante risus facilisis odio, vel facilisis nunc nisi eget dui. Pellentesque ullamcorper, augue scelerisque imperdiet luctus, eros massa sodales magna, eu volutpat eros ipsum vitae nisi. Nullam mattis vel orci venenatis condimentum. Sed id convallis urna. Aenean vel turpis vestibulum, pulvinar nisi id, dignissim metus. Donec consectetur felis eu tristique interdum. Curabitur sit amet maximus neque.</p>
                            <p>Proin nec sem scelerisque, semper elit id, finibus elit. Duis convallis, quam in ornare rhoncus, sapien sapien varius quam, quis ullamcorper dui lacus sit amet odio. Etiam euismod pretium arcu, quis pellentesque velit iaculis eu. Sed faucibus nunc ut ex tincidunt, et varius mauris tincidunt. Suspendisse potenti. Etiam quis hendrerit massa, id fringilla enim. Nunc pellentesque nec lectus et vehicula. Phasellus rhoncus urna eget ante pulvinar, id tristique urna malesuada. Nullam interdum lectus ut mauris efficitur, eget tincidunt lacus eleifend. Quisque quis odio faucibus, condimentum mauris vel, imperdiet orci. Pellentesque elit velit, tempor eget varius at, imperdiet ac metus.</p>
                        </div>
                        <button class="btn btn-success right" type="button" id="acceptConditionButton">J'accepte</button>
                        <button class="btn btn-danger left" type="button" id="doesntAcceptConditionButton">Je n'accepte pas</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="form-group col-md-12">
            <button class="btn" id="creerCompteButton" type="submit" value="creerNouveauCompte" name="action">Valider</button>
            
        </div>
    </div>
    
</form>
