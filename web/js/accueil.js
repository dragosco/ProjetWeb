$(document).ready(function() {

    function listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix) {
        //document.write('<div>Print this after the script tag</div> filtrerVentes');
        
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Accueil?action=listerVentes&debut=" + debut +"&nombreParPage=" + nombreParPage +"&motscles=" + motscles +"&categorie=" + categorie +"&ecole=" + ecole +"&etudiant=" + etudiant +"&prix=" + prix,  
            dataType: 'json',
            success: function (data) {
                //document.write(data);
                //document.write('<div>Print this after the script tag</div> filtrerVentes');
                var page = debut/nombreParPage + 1;
                var nbPages = Math.floor(total / nombreParPage) + 1; 
                
                //nettoyage de la table (sauf la première ligne correspondant aux titres
                $('#listeVentes li').remove();
                //
                
                
                //alert(JSON.stringify(data));
//                $("#totalVentes").val(data.object[0]);
                
                var _len = data.length;
                var item, i;
                
                $("#totalVentes").val(total = data[0].total);
                
                if (debut <= 0) {
                    $("#previewButton").hide();
                } else {
                    $("#previewButton").show();
                }
                //alert("debut " + debut + " nombreParPage " + nombreParPage + " total " + total + " data.length " + (data.length-1));
                
                if(debut + nombreParPage >= total) { //  || (data.length-1) <= nombreParPage
                    $("#nextButton").hide();
                } else {
                    $("#nextButton").show();
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
                    $('#listeVentes')
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
                                                    "<a href='Accueil'>Annuler</a>" +
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


//                            "<li>" + 'test' +
//                            "</li>");
                
                    //alert("m_positionName is "+ post. m_positionName);
                }
                
//                data.forEach(function (item) {
////                    if(index === 0) {
////                        alert("total");
////                        $("#totalVentes").val(item.total);
////                        alert(item.total);
////                    } else {
//                    var photo = "resources/default_profile.jpg";
////                    if(item.photo !== false) {
////                        photo = "Image/auteur/" + item.id;
////                    }
//                    $('#listeVentes')
//                        .append(                        
//                            "<li class='list-group-item'>" + 
//                                "<div class='annonce row' style='position: relative;'>" +
//                                    //"<c:if test="${sessionScope.PRIVILEGE == 'admin'}">" + 
//                                        "<a class='outil-link suppr on-element' type='submit' data-toggle='modal' data-target='#modalSupprAnnc${a.id}'><span class='glyphicon glyphicon-remove'></span></a>" +
//                                        "<div class='modal fade' id='modalSupprAnnc${a.id}' role='dialog'>" +
//                                          "<div class='modal-dialog'>" +
//                                            "<div class='modal-content'>" +
//                                                "Etes-vous certain de vouloir supprimer cette annonce ?" +
//                                                "<form action='Admin' method='post'>" +
//                                                    "<input type='hidden' value=" + item.id + " name='id' />" +
//                                                    "<button type='submit' value='supprimerAnnonce' name='action'>Confirmer</button>" +
//                                                    "<hr>" +
//                                                    "<a href='Accueil'>Annuler</a>" +
//                                                "</form>" +
//                                            "</div>" + 
//                                          "</div>" + 
//                                        "</div>" + 
//                                    //</c:if>
//                                    "<div class='couleurAnnonce col-md-1'></div>" +
//                                    "<div class='infoEtudiant col-md-3'>" +
//                                        "<a href='Profil?user=adminThais'>" +
////                                            <c:choose>
////                                                <c:when test="${a.auteur.photo != null}">
////                                                    <img src="Image/auteur/${a.auteur.id}" class="img-rounded photoEtudiant">
////                                                </c:when>
////                                                <c:otherwise>
//                                                    "<img src=" + photo + " class='img-rounded photoEtudiant'>" + 
////                                                </c:otherwise>
////                                            </c:choose>
//                                        "</a>" +
////                                        "<p>" + item.auteur.prenom ${a.auteur.nom} + "</p>"+
////                                        <p>${a.auteur.ecole.nom}</p>
//                                    "</div>" + 
//                                    "<div class='infoProduit col-md-4'>" +
////                                        <a href="Annonce?id=${a.id}"><p>${a.titre}</p></a>
////                                        <p>${a.categorie.nom}</p>
////                                        <p>Date ajout : <fmt:formatDate type="both" value="${a.dateDepot}" /></p>
////                                        <p>Date fin : <fmt:formatDate type="date" value="${a.dateFin}" /></p>
//                                    "</div>" + 
//                                    "<div class='prixProduit col-md-2'>" +
//                                        "<p>" + item.prix +"\u20AC</p>" +
//                                    "</div>" + 
//                                    "<div class='photosProduit col-md-2'>" +
////                                        <c:choose>
////                                            <c:when test="${fn:length(a.photos) > 0}">
//////                                                "<p><img src='Image/produit/+${a.photos[0].id}" class="img-rounded photoProduit"/></p>
////                                                <span class="iconPhoto">
////                                                    <img src="resources/camera.png" class="icon"/>
////                                                    <span class="nombrePhotos">
////                                                        ${fn:length(a.photos)}
////                                                    </span>
////                                                </span>
////                                            </c:when>
////                                            <c:otherwise>
////                                                <p><img src="resources/no_foto.jpg" class="img-rounded photoProduit"></p>
////                                            </c:otherwise>
////                                        </c:choose>                                    
//                                    "</div>" + 
//                                "</div>" + 
//                            "</li>");
//
//
////                            "<li>" + 'test' +
////                            "</li>");
//                });
//                    index = index + 1;
//                });
            },
            error : function(data,status,er) {
                alert("error: "+data+" status: "+status+" er:"+er);
            }
        });
    };

    function updateTableVentes() {
        //document.write('<div>Print this after the script tag</div> updateTableVentes');
        
        setValeursDefault();
        var debut = 0;
        var nombreParPage = 2;
        var total = $("#totalVentes").val();
        //alert(total);
        listerVentes(debut, nombreParPage, total, '', '', '', '', '');
        
        var motscles = $("#motscles").val();
        var categorie = $("#categorie").val();
        var ecole = $("#ecole").val();
        var etudiant = $("#etudiant").val();
        var prix = $("#amount").val();
        
        $("#nombreParPage").change(function() {
            total = $("#totalVentes").val();
            debut = 0;
            nombreParPage = parseInt($(this).val());
            listerVentes(debut, nombreParPage, total);
        });
        
        $("#recherche").click(function () {
            total = $("#totalVentes").val();
            //alert(total);
            debut = 0;
            motscles = $("#motscles").val();
            categorie = $("#categorie").val();
            ecole = $("#ecole").val();
            etudiant = $("#etudiant").val();
            prix = $("#amount").val();
            
            //alert('etudiant ' + etudiant)
            listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#nextButton").click(function () {
            total = $("#totalVentes").val();
            debut = debut + nombreParPage;
            listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#previewButton").click(function () {
            total = $("#totalVentes").val();
            debut = debut - nombreParPage;
            listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });

        $("#startButton").click(function () {
            total = $("#totalVentes").val();
            debut = 0;
            listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });
        
        $("#endButton").click(function () {
            total = $("#totalVentes").val();
            var reste = total % nombreParPage;
            if(reste !== 0) {
                debut = total - reste;
            } else {
                debut = total - nombreParPage;
            }
            listerVentes(debut, nombreParPage, total, motscles, categorie, ecole, etudiant, prix);
        });
        
    };
    
    function setValeursDefault() {
        $("#motscles").val('');
        $("#categorie").selectedIndex = 0;
        $("#ecole").selectedIndex = 0;
        $("#etudiant").val('');
        //$("#amount").val();
    }
    
    updateTableVentes();

//    $(function() {
//        $("#slider-range").slider({
//            range: true,
//            min: ${minPrix},
//            max: ${maxPrix},
//            values: [${minPrix}, ${maxPrix}],
//            slide: function(event, ui) {
//              $("#amount").val(ui.values[0] + "€" + " - " + ui.values[1] + "€");
//            }
//        });
//        $("#amount").val($("#slider-range").slider("values", 0) + "€" +
//          " - " + $("#slider-range").slider("values", 1) + "€" );
//    });
});