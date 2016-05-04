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
                $('#listeRecherches a').remove();
                //
                
                
                //alert(JSON.stringify(data));
//                $("#totalVentes").val(data.object[0]);
                
                var _len = data.length;
                var item, i;
                
                $("#totalRecherches").val(total = data[0].total);
                
                if (debut <= 0) {
                    $("#startButtonRecherche").hide();
                    $("#previewButtonRecherche").hide();
                } else {
                    $("#startButtonRecherche").show();
                    $("#previewButtonRecherche").show();
                }
                //alert("debut " + debut + " nombreParPage " + nombreParPage + " total " + total + " data.length " + (data.length-1));
                
                if(debut + nombreParPage >= total) { //  || (data.length-1) <= nombreParPage
                    $("#nextButtonRecherche").hide();
                    $("#endButtonRecherche").hide();
                } else {
                    $("#nextButtonRecherche").show();
                    $("#endButtonRecherche").show();
                }
                
//                if(debut + nombreParPage >= total) { //  || (data.length-1) <= nombreParPage
//                    $("#endButton").hide();
//                } else {
//                    $("#endButton").show();
//                }
                //alert(JSON.stringify(data[0].total));

                if(_len < 2) {
                    $('#listeRecherches').append("<h3>Aucune recherche trouvée</h3>");
                } else {
                    for (i = 1; i < _len; i++) {
                        //debugger
                        item = data[i];
                        var photo = "resources/default_profile.jpg";

                        var recherche = "<a href='Annonce?id=" + item.id + "' class='list-group-item list-arrondie-item'>" +
                                    "<div class='row'>" +
                                        "<div class='col-md-2'>" + 
                                                "<div class='photo-annonce-wrapper'>"; 

                        if(item.qdtPhotos > 0) {
                            recherche += "<img src='Image/produit/" + item.idPhoto + "' class='photo-annonce' />";
                        } else {
                            recherche += "<img src='resources/no-image.png' class='photo-annonce-null' />";
                        }               

                        recherche += "<br>" + 
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
                            recherche += "Valable jusqu'au " + item.dateFin + " />";
                        } else {
                            recherche += "Sans date de validité";
                        }            

                        recherche += "</span>" +
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
                            recherche += "<img src='Image/auteur/" + item.idAuteur + "' class='photo-profil-annonce'>";
                        } else {
                            recherche += "<img src='resources/default_profile.jpg' class='photo-profil-annonce'>";
                        }
    //                                    
                        recherche += "</div>" + "</a>";  

                        $('#listeRecherches').append(recherche);
                    }
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
        var nombreParPage = 10;
        var total = $("#totalRecherches").val();
        //alert(total);
        listerRecherches(debut, nombreParPage, total, '', 0, 0, '', '');
        
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