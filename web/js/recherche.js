$(document).ready(function() {

    function listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix) {
        //document.write('<div>Print this after the script tag</div> filtrerVentes');
        
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Recherche?action=listerRecherches&debut=" + debut +"&nombreParPage=" + nombreParPage +"&motscles=" + motscles +"&categorie=" + categorie +"&ecole=" + ecole +"&etudiant=" + etudiant +"&prix=" + prix,  
            dataType: 'json',
            success: function (data) {
                //document.write(data);
                //document.write('<div>Print this after the script tag</div> filtrerVentes');
                var page = debut/nombreParPage + 1;
                var nbPages = Math.floor(total / nombreParPage) + 1; 
                
                //nettoyage de la table (sauf la première ligne correspondant aux titres
                $('#listeRecherches li').remove();
                //
                
                
                //alert(JSON.stringify(data));
//                $("#totalVentes").val(data.object[0]);
                
                var _len = data.length;
                var item, i;
                
                $("#totalRecherches").val(total = data[0].total);
                
                if (debut <= 0) {
                    $("#previewButtonRecherche").hide();
                } else {
                    $("#previewButtonRecherche").show();
                }
                //alert("debut " + debut + " nombreParPage " + nombreParPage + " total " + total + " data.length " + (data.length-1));
                
                if(debut + nombreParPage >= total) { //  || (data.length-1) <= nombreParPage
                    $("#nextButtonRecherche").hide();
                } else {
                    $("#nextButtonRecherche").show();
                }
                
//                if(debut + nombreParPage >= total) { //  || (data.length-1) <= nombreParPage
//                    $("#endButton").hide();
//                } else {
//                    $("#endButton").show();
//                }
                //alert(JSON.stringify(data[0].total));

                for (i = 1; i < _len; i++) {
                    //debugger
                    item = data[i];
                    var photo = "resources/default_profile.jpg";
//                    if(item.photo !== false) {
//                        photo = "Image/auteur/" + item.id;
//                    }
                    $('#listeRecherches')
                        .append(                        
                            "<li class='list-group-item'>" + 
                                "<div class='annonce row' style='position: relative;'>" +
                                    //"<c:if test="${sessionScope.PRIVILEGE == 'admin'}">" + 
                                        "<a class='outil-link suppr on-element' type='submit' data-toggle='modal' data-target='#modalSupprAnnc" + item.id + "'><span class='glyphicon glyphicon-remove'></span></a>" +
                                        "<div class='modal fade' id='modalSupprAnnc" + item.id + "' role='dialog'>" +
                                          "<div class='modal-dialog'>" +
                                            "<div class='modal-content'>" +
                                                "Etes-vous certain de vouloir supprimer cette annonce ?" +
                                                "<form action='Admin' method='post'>" +
                                                    "<input type='hidden' value=" + item.id + " name='id' />" +
                                                    "<button type='submit' value='supprimerAnnonce' name='action'>Confirmer</button>" +
                                                    "<hr>" +
                                                    "<a href='Recherche'>Annuler</a>" +
                                                "</form>" +
                                            "</div>" + 
                                          "</div>" + 
                                        "</div>" + 
                                    //</c:if>
                                    "<div class='couleurAnnonce col-md-1'></div>" +
                                    "<div class='infoEtudiant col-md-3'>" +
                                        "<a href='Profil?user=adminThais'>" +
//                                            <c:choose>
//                                                <c:when test="${a.auteur.photo != null}">
//                                                    <img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant">
//                                                </c:when>
//                                                <c:otherwise>
                                                    "<img src=" + photo + " class='img-rounded photoEtudiant'>" + 
//                                                </c:otherwise>
//                                            </c:choose>
                                        "</a>" +
//                                        "<p>" + item.auteur.prenom ${a.auteur.nom} + "</p>"+
//                                        <p>${a.auteur.ecole.nom}</p>
                                    "</div>" + 
                                    "<div class='infoProduit col-md-4'>" +
//                                        <a href="Annonce?id=${a.id}"><p>${a.titre}</p></a>
//                                        <p>${a.categorie.nom}</p>
//                                        <p>Date ajout : <fmt:formatDate type="both" value="${a.dateDepot}" /></p>
//                                        <p>Date fin : <fmt:formatDate type="date" value="${a.dateFin}" /></p>
                                    "</div>" + 
                                    "<div class='prixProduit col-md-2'>" +
                                        "<p>" + item.prix +"\u20AC</p>" +
                                    "</div>" + 
                                    "<div class='photosProduit col-md-2'>" +
//                                        <c:choose>
//                                            <c:when test="${fn:length(a.photos) > 0}">
////                                                "<p><img src='Image/produit/+${a.photos[0].id}" class="img-rounded photoProduit"/></p>
//                                                <span class="iconPhoto">
//                                                    <img src="resources/camera.png" class="icon"/>
//                                                    <span class="nombrePhotos">
//                                                        ${fn:length(a.photos)}
//                                                    </span>
//                                                </span>
//                                            </c:when>
//                                            <c:otherwise>
//                                                <p><img src="resources/no_foto.jpg" class="img-rounded photoProduit"></p>
//                                            </c:otherwise>
//                                        </c:choose>                                    
                                    "</div>" + 
                                "</div>" + 
                            "</li>");
                }
            },
            error : function(data,status,er) {
                alert("error: "+data+" status: "+status+" er:"+er);
            }
        });
    };

    function updateTableRecherches() {
        //document.write('<div>Print this after the script tag</div> updateTableVentes');
        
        setValeursDefault();
        var debut = 0;
        var nombreParPage = 2;
        var total = $("#totalRecherches").val();
        //alert(total);
        listerRecherches(debut, nombreParPage, total, '', '', '', '', '');
        
        var motscles = $("#motsclesRecherche").val();
        var categorie = $("#categorieRecherche").val();
        var ecole = $("#ecoleRecherche").val();
        var etudiant = $("#etudiantRecherche").val();
        var prix = $("#amountRecherche").val();
        
        $("#nombreParPageRecherche").change(function() {
            total = $("#totalRecherches").val();
            debut = 0;
            nombreParPage = parseInt($(this).val());
            listerRecherches(debut, nombreParPage, total);
        });
        
        $("#rechercheRecherche").click(function () {
            total = $("#totalRecherches").val();
            //alert(total);
            debut = 0;
            motscles = $("#motsclesRecherche").val();
            categorie = $("#categorieRecherche").val();
            ecole = $("#ecoleRecherche").val();
            etudiant = $("#etudiantRecherche").val();
            prix = $("#amountRecherche").val();
            
            //alert('etudiant ' + etudiant)
            listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#nextButtonRecherche").click(function () {
            total = $("#totalRecherches").val();
            debut = debut + nombreParPage;
            listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#previewButtonRecherche").click(function () {
            total = $("#totalRecherches").val();
            debut = debut - nombreParPage;
            listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#startButtonRecherche").click(function () {
            total = $("#totalRecherches").val();
            debut = 0;
            listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });
        
        $("#endButtonRecherche").click(function () {
            total = $("#totalRecherches").val();
            var reste = total % nombreParPage;
            if(reste !== 0) {
                debut = total - reste;
            } else {
                debut = total - nombreParPage;
            }
            listerRecherches(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });
        
    };
    
    function setValeursDefault() {
        $("#motsclesRecherche").val('');
        $("#categorieRecherche").selectedIndex = 0;
        $("#ecoleRecherche").selectedIndex = 0;
        $("#etudiantRecherche").val('');
        //$("#amount").val();
    }
    
    updateTableRecherches();
});