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
    
    //lire la photo de l'input file
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                
                $('#target').attr('src', e.target.result);
                //on découpe
                $('.previewPhotoProfil').Jcrop({
      
                  onSelect: updateCoords,
                    
                        bgOpacity:   .4,
                        setSelect:   [ 150, 150, 50, 50 ],
                        aspectRatio: 16 / 16
                });
                
            };
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#inputPhotoProfil").change(function(){
        $(".preview-container img").remove();
        $(".preview-container").html('<img class="previewPhotoProfil" id="target" alt="Votre photo de profil ici" style="width: 100%; height: auto;"/>');
        readURL(this);
        
    });
    //les coordonnées du découpe servent à découper la photo lors du chargement sur la servlet
    function updateCoords(c)
    {
        $('#x').val(c.x);
        $('#y').val(c.y);
        $('#w').val(c.w);
        $('#h').val(c.h);
    };

    //etant donné que le preview de la photo n'a pas la même taille que la photo originale
    //lorsqu'on récupère les coordonnées de découpage il faut multiplier ces coordonnées par un ratio
    //le ratio est determiné en divisant la taille originale par la valeur du 'ratiodivider' ci-bas
    $("#ratiodivider").val($("#target").width());
    
//PROFIL : enable popover
    $("[data-toggle='popover']").popover();
    
    $('body').on('click', function (e) {
        $('[data-toggle="popover"]').each(function () {
            //the 'is' for buttons that trigger popups
            //the 'has' for icons within a button that triggers a popup
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                $(this).popover('hide');
            }
        });
    });
    
    $(document).on("click", ".popover .close" , function(){
        $(this).parents(".popover").popover('hide');
    });
    
    $("#label-vente").click(function() {
        if ($("#vente-radio-btn").prop("checked", true)) {
            $("#label-vente").css("background-color", "red");
        } else {
            $("#label-vente").css("background-color", "orange");
        }
    });
    
    if ($("#recherche-radio-btn").prop("checked", true)) {
        $("#label-recherche").css("background-color", "red");
    } else {
        $("#label-recherche").css("background-color", "orange");
    }
});


