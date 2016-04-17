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

