$(document).ready(function() {
//ADMIN : afficher le tableau d'utilisateurs avec AJAX
    function listerUtilisateurs(start, nParPage, total) {
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Admin?action=listerUtilisateurs&start=" + start +"&nParPage=" + nParPage,  
            dataType: 'json',
            success: function (data) {
                var page = start/nParPage + 1;
                var nbPages = Math.floor(total / nParPage) + 1; 
                $("#quellePage").empty();
                $("#quellePage").append("Page " + page + " sur " + nbPages);
                
                //nettoyage de la table (sauf la première ligne correspondant aux titres
                $('table#userTable tbody').find("tr:gt(0)").remove();
                //
                if (start <= 0) {
                    $("#previewButton, #startButton").hide();
                } else {
                    $("#previewButton, #startButton").show();
                }
                if(start + nParPage === total || data.length < nParPage) {
                    $("#nextButton, #endButton").hide();
                } else {
                    $("#nextButton, #endButton").show();
                }
                data.forEach(function (item) {
                    var photo = "resources/default_profile.jpg";
                    if(item.photo !== false) {
                        photo = "Image/auteur/" + item.id;
                    }
                    $('table#userTable tbody')
                        .append(
                            "<tr>" + 
                                "<td><img class='img-rounded photoEtudiant' src='" + photo + "'></td>" + 
                                "<td>" + item.id + "</td>" + 
                                "<td>" + item.privilege + "</td>" +
                                "<td><a href=Profil?user=" + item.pseudo + " >" + item.pseudo + "</a></td>" + 
                                "<td>" + item.nom + "</td>" +
                                "<td>" + item.prenom + "</td>" + 
                                "<td>" + item.ecole + "</td>" + 
                                "<td>" + item.tel + "</td>" + 
                                "<td>" + item.mail + "</td>" + 
                                "<td>" + "<a class='outil-link edit' type='submit' data-toggle='modal' data-target='#modalPriv" + item.pseudo + "'><span class='glyphicon glyphicon-pencil'></span></a>" +
                                            "<div class='modal fade' id='modalPriv" + item.pseudo + "' role='dialog'>" +
                                              "<div class='modal-dialog'>" +
                                                "<button type='button' class='close dismiss-button' data-dismiss='modal' style='margin-top:-30px;margin-right: -30px;'><span class='glyphicon glyphicon-remove-circle'></span></button>" +
                                                "<div class='modal-content'>" +
                                                    "Changer les droits de " + item.pseudo +
                                                    "<form action='Admin' method='post'>" +
                                                        "<select name='privilege'><option value='user'>user</option><option vlaue='admin'>admin</option></select>" +
                                                        "<input type='hidden' value='" + item.pseudo + "' name='pseudo' />" +
                                                        "<button type='submit' value='changePrivilege' name='action'>Confirmer</button>" +
                                                        "<hr>" +
                                                        "<a href='Admin'>Annuler</a>" +
                                                    "</form>" +
                                                "</div>" +
                                              "</div>" +
                                            "</div>" +
                                         "<a class='outil-link suppr' type='submit' data-toggle='modal' data-target='#modalSuppr" + item.pseudo + "'><span class='glyphicon glyphicon-remove'></span></a>" +
                                            "<div class='modal fade' id='modalSuppr" + item.pseudo + "' role='dialog'>" +
                                                "<div class='modal-dialog'>" +
                                                    "<button type='button' class='close dismiss-button' data-dismiss='modal' style='margin-top:-30px;margin-right: -30px;'><span class='glyphicon glyphicon-remove-circle'></span></button>" +
                                                    "<div class='modal-content'>" +
                                                        "Etes-vous certain de vouloir supprimer l'utilisateur " + item.pseudo + " ?" +
                                                        "<form action='Admin' method='post'>" +
                                                            "<input type='hidden' value='" + item.id + "' name='id' />" +
                                                            "<button type='submit' value='supprimerUtilisateur' name='action'>Confirmer</button>" +
                                                            "<hr>" +
                                                            "<a href='Admin'>Annuler</a>" +
                                                        "</form>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                "</td>" +
                            "</tr>");
                });
            }
        });
    };

    function updateTableUsers() {
        var start = 0;
        var nParPage = 10;
        var total = $("#totalUsers").val();
        listerUtilisateurs(start, 10, total);
        
        $("#nParPage").change(function() {
            start = 0;
            nParPage = parseInt($(this).val());
            listerUtilisateurs(start, nParPage, total);
        });

        $("#nextButton").click(function () {
            start = start + nParPage;
            listerUtilisateurs(start, nParPage, total);
        });

        $("#previewButton").click(function () {
            start = start - nParPage;
            listerUtilisateurs(start, nParPage, total);
        });

        $("#startButton").click(function () {
            start = 0;
            listerUtilisateurs(start, nParPage, total);
        });
        
        $("#endButton").click(function () {
            var reste = total % nParPage;
            start = total - reste;
            listerUtilisateurs(start, nParPage, total);
        });
        
        
        
    }
    
    updateTableUsers();
    
//ADMIN : afficher les photos des annonces avec AJAX   
    function listerPhotos(start, nParPage) {
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Admin?action=listerPhotos&start=" + start +"&nParPage=" + nParPage,  
            dataType: 'json',
            success: function (data) {
                //nettoyage de la table (sauf la première ligne correspondant aux titres
                $("#photosContainer").empty();
                $("#photosContainer").append("<h5>Photos annonces</h5>");
                //
                if (start <= 0) {
                    $("#previewButtonPhotos, #startButtonPhotos").hide();
                } else {
                    $("#previewButtonPhotos, #startButtonPhotos").show();
                }
                
                if(data.length < nParPage || data.length === 0) {
                    $("#nextButtonPhotos, #endButtonPhotos").hide();
                } else {
                    $("#nextButtonPhotos, #endButtonPhotos").show();
                }
                
                data.forEach(function (item) {
                    $("#photosContainer").append(
                            "<div class='imageWrapper'>" +
                                "<img src='Image/produit/" + item.id + "' style='width:200px; height: auto;'>" +
                                "<a class='outil-link suppr on-element' type='submit' data-toggle='modal' data-target='#modalSupprPhoto" + item.id + "'><span class='glyphicon glyphicon-remove'></span></a>" +
                                "<div class='modal fade' id='modalSupprPhoto" + item.id + "' role='dialog'>" +
                                  "<div class='modal-dialog'>" +
                                    "<button type='button' class='close dismiss-button' data-dismiss='modal' style='margin-top:-30px;margin-right: -30px;'><span class='glyphicon glyphicon-remove-circle'></span></button>" +
                                    "<div class='modal-content'>" +
                                        "Etes-vous certain de vouloir supprimer cette photo ?" +
                                        "<img src='Image/produit/" + item.id + "' style='width:200px; height: auto;'>" +
                                        "<form action='Admin' method='post'>" +
                                            "<input type='hidden' value='" + item.id + "' name='id' />" +
                                            "<button type='submit' value='supprimerPhoto' name='action'>Confirmer</button>" +
                                            "<hr>" +
                                            "<a href='Admin'>Annuler</a>" +
                                        "</form>" +
                                    "</div>" +
                                  "</div>" +
                                "</div>" +
                            "</div>"
                            );
                });
            }
        });
    };
    
    function updateTablePhotos() {
        var start = 0;
        var nParPage = 10;
        listerPhotos(start, 10);

        $("#nPhotosParPage").change(function() {
            start = 0;
            nParPage = parseInt($(this).val());
            listerPhotos(start, nParPage);
        });

        $("#nextButtonPhotos").click(function () {
            start = start + nParPage;
            listerPhotos(start, nParPage);
        });

        $("#previewButtonPhotos").click(function () {
            start = start - nParPage;
            listerPhotos(start, nParPage);
        });

        $("#startButtonPhotos").click(function () {
            start = 0;
            listerPhotos(start, nParPage);
        });
        
        $("#endButtonPhotos").click(function () {
            start = 0;
            listerPhotos(start, nParPage);
        });
        
    }
    
    updateTablePhotos();
    
    function listerPhotosProfil(start, nParPage) {
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Admin?action=listerUtilisateursAvecPhotoProfil&start=" + start +"&nParPage=" + nParPage,  
            dataType: 'json',
            success: function (data) {
                //nettoyage de la table (sauf la première ligne correspondant aux titres
                $("#photosProfilContainer").empty();
                $("#photosProfilContainer").append("<h5>Photos de profil</h5>");
                
                if (start <= 0) {
                    $("#previewButtonPhotosProfil, #startButtonPhotosProfil").hide();
                } else {
                    $("#previewButtonPhotosProfil, #startButtonPhotosProfil").show();
                }
                
                if(data.length < nParPage || data.length === 0) {
                    $("#nextButtonPhotosProfil, #endButtonPhotosProfil").hide();
                } else {
                    $("#nextButtonPhotosProfil, #endButtonPhotosProfil").show();
                }
                
                data.forEach(function (item) {
                    $("#photosProfilContainer").append(
                        "<div class='imageWrapper'>" +
                            "<img src='Image/auteur/" + item.id + "' style='width:150px; height: auto;'>" +
                            "<a class='outil-link suppr on-element' type='submit' data-toggle='modal' data-target='#modalSupprPhoto" + item.id + "'><span class='glyphicon glyphicon-remove'></span></a>" +
                            "<div class='modal fade' id='modalSupprPhoto" + item.id + "' role='dialog'>" +
                              "<div class='modal-dialog'>" +
                                "<button type='button' class='close dismiss-button' data-dismiss='modal' style='margin-top:-30px;margin-right: -30px;'><span class='glyphicon glyphicon-remove-circle'></span></button>" +
                                "<div class='modal-content'>" +
                                    "Etes-vous certain de vouloir supprimer cette photo ?" +
                                    "<img src='Image/auteur/" + item.id + "' style='width:200px; height: auto;'>" +
                                    "<form action='Admin' method='post'>" +
                                        "<input type='hidden' value='" + item.id + "' name='id' />" +
                                        "<button type='submit' value='supprimerPhoto' name='action'>Confirmer</button>" +
                                        "<hr>" +
                                        "<a href='Admin'>Annuler</a>" +
                                    "</form>" +
                                "</div>" +
                              "</div>" +
                            "</div>" +
                        "</div>"
                        );
                    
                });
            }
        });
    };
    
    function updateTablePhotosProfil() {
        var start = 0;
        var nParPage = 10;
        listerPhotosProfil(start, 10);

        $("#nPhotosProfilParPage").change(function() {
            start = 0;
            nParPage = parseInt($(this).val());
            listerPhotosProfil(start, nParPage);
        });

        $("#nextButtonPhotosProfil").click(function () {
            start = start + nParPage;
            listerPhotosProfil(start, nParPage);
        });

        $("#previewButtonPhotosProfil").click(function () {
            start = start - nParPage;
            listerPhotosProfil(start, nParPage);
        });

        $("#startButtonPhotosProfil").click(function () {
            start = 0;
            listerPhotosProfil(start, nParPage);
        });
        
        $("#endButtonPhotosProfil").click(function () {
            start = 0;
            listerPhotosProfil(start, nParPage);
        });
    };
    
    updateTablePhotosProfil();
});