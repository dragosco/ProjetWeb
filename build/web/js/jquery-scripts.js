$(document).ready(function(){
    //COMPTE : créer un nouveau compte
    //requête ajax afin de vérifier l'existence du pseudo
    
    $("#inputPseudo").keyup(function() { //si le message d'erreur s'affiche, il se cache quand on retape le pseudo
        $('#compteKO').empty();
    });
    
    $("#inputPseudo").focusout(function () {
        $.ajax({
            type: 'GET',
            url: "/ProjetWeb/Compte?pseudo=" + $(this).val(),  
            dataType: 'json',
            success: function (data) {
                console.log(data.existe);
                if(data.existe === "true") {
                    $("#compteKO").html('<span class="glyphicon glyphicon-ban-circle"></span> Le pseudo que vous avez choisi existe déjà !');
                    $("#creerCompteButton").prop('disabled', true);
                } else {
                    $("#compteKO").empty();
                    $("#creerCompteButton").prop('disabled', false);
                }
            }
        });
    });
    
    //vérifie que les mots de passe correspondent
    $('#verifMotDePasse, #motDePasse').keyup(function() {
        if($('#motDePasse').val() === $('#verifMotDePasse').val()){
            $('#creerCompteButton').prop('disabled', false);
            $("#echecMDP").empty();
        } else {
            $('#creerCompteButton').prop('disabled', true);
            $("#echecMDP").html("Les mots de passe ne correspondent pas !");
        }
    });
    
    //le bouton 
    $("#checkConditions").click(function () {
        if (this.checked) {
            $("#conditionsKO").empty();
        } else {
            $("#conditionsKO").html("Attention ! Si vous n'acceptez les Termes et Conditions d'utilisation, vous ne pouvez pas créer un compte.");
        }
    });
    
    $("#acceptConditionButton").click(function () {
        $("#modalTermesConditions").modal("toggle");
        $("#checkConditions").prop("checked", true);
        $("#conditionsKO").empty();
    });
    
    $("#doesntAcceptConditionButton").click(function () {
        $("#modalTermesConditions").modal("toggle");
        $("#checkConditions").prop("checked", false);
        $("#conditionsKO").html("Attention ! Si vous n'acceptez les Termes et Conditions d'utilisation, vous ne pouvez pas créer un compte.");
    });
    
//PROFIL : enable popover
    $("[data-toggle='popover']").popover();
    
    function previewPhotoProfil(photo, output) {

        if (photo.files && photo.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $(output).attr('src', e.target.result);
            };
            
            reader.readAsDataURL(photo.files[0]);
        }
    };
    $("#inputNouvPhotoProfil").change(function(){
        previewPhotoProfil(this, '#previewNouvPhotoProfil');
    });
    $("#inputPhotoProfil").change(function(){
        previewPhotoProfil(this, '#previewPhotoProfil');
    });
    
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
});


