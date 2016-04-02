$(document).ready(function(){
    $('[data-toggle="popover"]').popover();
});

function afficheImages(files) {
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
    afficheImages(evt.dataTransfer.files);
};

function dragOver(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy';
};

var dropArea = document.getElementById('dropArea');
dropArea.addEventListener('dragover', dragOver, false);
dropArea.addEventListener('drop', imagesDragDrop, false);
  
function imagesSelect(evt) {
    afficheImages(evt.target.files);
};

document.getElementById('files').addEventListener('change', imagesSelect, false);
