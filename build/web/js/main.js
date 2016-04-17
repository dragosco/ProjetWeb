//COMPTE : preview photo de profil
function previewPhotoProfil(photo) {

        if (photo.files && photo.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#previewPhotoProfil').attr('src', e.target.result);
            };
            
            reader.readAsDataURL(photo.files[0]);
        }
    };

$("#inputPhotoProfil").change(function(){
    previewPhotoProfil(this);
});


//DEPOT ANNONCE : preview images annonces + drag and drop
function previewImages(files) {
    for (var i = 0, f; f = files[i]; i++) {
      
        if (!f.type.match('image.*')) {
          continue;
        }

        var reader = new FileReader();

        reader.onload = (function(theFile) {
          return function(e) {
            var span = document.createElement('span');
            span.innerHTML = ['<img src="', e.target.result,
                              '" title="', escape(theFile.name), '" style="max-width: 50%; height: auto;" />'].join('');
            document.getElementById('previewImages').insertBefore(span, null);
          };
        })(f);

        reader.readAsDataURL(f);
    }
};
    
function imagesDragDrop(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    previewImages(evt.dataTransfer.files);
};

function dragOver(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy';
};

var dropArea = document.getElementById('dropAreaAnnonce');
dropArea.addEventListener('dragover', dragOver, false);
dropArea.addEventListener('drop', imagesDragDrop, false);

function imagesSelect(evt) {
    previewImages(evt.target.files);
};

document.getElementById('files').addEventListener('change', imagesSelect, false);

//var prixSlider = document.getElementById('prix');
//
//noUiSlider.create(prixSlider, {
//    range: {
//        'min': 0,
//        '10%': 10,
//        '20%': 20,
//        '30%': 30,
//	'40%': 40,
//        '50%': 50,
//        '60%': 60,
//        '70%': 70,
//	'80%': 80,
//        '90%': 90,
//        'max': 100
//    },
//    snap: true,
//    start: [20, 90]
//});
//
//var skipValues = [
//	document.getElementById('skip-value-lower'),
//	document.getElementById('skip-value-upper')
//];
//
//prixSlider.noUiSlider.on('update', function( values, handle ) {
//	skipValues[handle].innerHTML = values[handle];
//});

//$(function() {
//    $( "#slider-range" ).slider({
//        range: true,
//        min: 0,
//        max: 500,
//        values: [ 75, 300 ],
//        slide: function( event, ui ) {
//            $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
//        }
//    });
//    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
//        " - $" + $( "#slider-range" ).slider( "values", 1 ) );
//});