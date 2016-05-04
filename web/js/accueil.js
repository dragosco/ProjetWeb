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
                $('#listeVentes a').remove();
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
                    //alert(item);
                    var photo = "resources/default_profile.jpg";
//                    if(item.photo !== false) {
//                        photo = "Image/auteur/" + item.id;
//                    }

                    var vente = "<a href='Annonce?id=" + item.id + "' class='list-group-item list-arrondie-item'>" +
                                "<div class='row'>" +
                                    "<div class='col-md-2'>" + 
                                            "<div class='photo-annonce-wrapper'>"; 
                                    
                    if(item.qdtPhotos > 0) {
                        vente += "<img src='Image/produit/" + item.idPhoto + "' class='photo-annonce' />";
                    } else {
                        vente += "<img src='resources/no-image.png' class='photo-annonce-null' />";
                    }               

                    vente += "<br>" + 
                                    "<div class='iconPhoto'>" + 
                                        "<img src='resources/camera.png' class='icon'/>" +
                                        "<span class='nombrePhotos'>" +
                                            + item.qdtPhotos +
                                        "</span>" + 
                                    "</div>" +
                                "</div>" +
                        "</div>" +
                        "<div class='col-md-10'>" +
                            "<div class='row list-item-contenu'>" +
                                "<div class='col-md-7'>" +
                                    "<span class='titre-annonce'>" + item.titre + "</span>" +
                                "</div>" +
                                "<div class='col-md-5'>" + 
                                    "<b>" + item.categorie + "</b>" + 
                                "</div>" + 
                            "</div>" +
                            "<div class='row list-item-contenu'>" +
                                "<div class='col-md-7'>" +
                                    "<span class='date'>Publiée par " + item.pseudo + " le " + item.dateDepotDate + " à " + item.dateDepotHeure + "</span>" +
                                            "</div>" +
                                            "<div class='col-md-5'>" +
                                                "<span class='date'>"; // + 
                                       
                    if(item.dateFin !== '') {
                        vente += "Valable jusqu'au " + item.dateFin + " />";
                    } else {
                        vente += "Sans date de validité";
                    }            
                    
                    vente += "</span>" +
                                    "</div>" +
                                "</div>" +

                                "<div class='row list-item-contenu'>" + 
                                    "<div class='col-md-7 too-long-text'>" +
                                        item.description +
                                    "</div>" +
                                    "<div class='col-md-5'>" +
                                        "<span style='color: #FF3800; font-size: 20px; '>" + item.prix + " €</span>" +
                                    "</div>" +
                                "</div>" +
                            "</div>";
                    
                    if(item.photoAuteur) {
                        vente += "<img src='Image/auteur/" + item.idAuteur + "' class='photo-profil-annonce'>";
                    } else {
                        vente += "<img src='resources/default_profile.jpg' class='photo-profil-annonce'>";
                    }
//                                    
                    vente += "</div>" + "</a>";  

                    $('#listeVentes').append(vente);
                    //$('#listeVentes').append("vente");
                }
            },
            error : function(data,status,er) {
                alert("error: "+data+" status: "+status+" er:"+er);
            }
            //}
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