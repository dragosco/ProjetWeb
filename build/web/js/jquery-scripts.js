$(document).ready(function(){
    //COMPTE : créer un nouveau compte
    //requête ajax afin de vérifier l'existence du pseudo
    $("#compteKO").hide(); //le message d'erreur est caché
    
    $('#inputPseudo').keyup(function() { //si le message d'erreur s'affiche, il se cache quand on retape le pseudo
        $('#compteKO').hide();
    });
    
    $("#inputPseudo").focusout(function () {
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Compte?pseudo=" + $(this).val(),  
            dataType: 'json',
            success: function (data) {
                console.log(data.existe);
                if(data.existe === "true") {
                    $("#compteKO").show();
                    $("#creerCompteButton").prop('disabled', true);
                } else {
                    $("#creerCompteButton").prop('disabled', false);
                }
                
            }
        });
    });
    
    //vérifie que les mots de passe correspondent
    $('#verifMotDePasse, #motDePasse').keyup(function() {
        if($('#motDePasse').val() === $('#verifMotDePasse').val()){
            $('#creerCompteButton').prop('disabled', false);
            $("#echecMDP").html("");
        } else {
            $('#creerCompteButton').prop('disabled', true);
            $("#echecMDP").html("Les mots de passe ne correspondent pas !");
        }
    });
    
    //si la case de Termes et Condition n'est pas cochée, le bouton de submit est 'disabled'
    $("#checkConditions").prop("checked", false);
    $("#creerCompteButton").prop('disabled', true);
    //si l'état 
    $("#checkConditions").change(function () {
        if (this.checked) {
            $("#conditionsKO").html("");
        } else {
            $("#conditionsKO").html("Attention ! Si vous n'acceptez les Termes et Conditions d'utilisation, vous ne pouvez pas créer un compte.");
        }
        
    });
    
    $("#acceptConditionBoutton").click(function () {
        $("#checkConditions").prop("checked", true);
        $("#modalTermesConditions").modal("toggle");
        $('#creerCompteButton').prop('disabled', false);
    });
    
    $("#doesntAcceptConditionBoutton").click(function () {
        $("#modalTermesConditions").modal("toggle");
        $("#checkConditions").prop("checked", false);
        $('#creerCompteButton').prop('disabled', true);
    });
//PROFIL : enable popover
    $('[data-toggle="popover"]').popover();
    
    //ADMIN : cacher les 3 conteneurs et les faire toggle on click
    var gu = $('#gestionUtilisateursContainer');
    var gp = $('#gestionPhotosContainer');
    var gc = $('#gestionCategoriesContainer');
    
    gp.hide();
    gc.hide();

    $('#gestionUtilisateursButton').click(function(e) {
            $('#gestionUtilisateursContainer').slideToggle('slow');
            e.preventDefault();
            gp.hide('slow');
            gc.hide('slow');
        });
                

    $('#gestionPhotosButton').click(function(e) {
            $('#gestionPhotosContainer').slideToggle('slow');
            e.preventDefault();
            gu.hide('slow');
            gc.hide('slow');
        });
        
    $('#gestionCategoriesButton').click(function(e) {
            $('#gestionCategoriesContainer').slideToggle('slow');
            e.preventDefault();
            gu.hide('slow');
            gp.hide('slow');
        });
    
    
});


