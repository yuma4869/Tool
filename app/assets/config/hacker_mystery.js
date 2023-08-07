alert("sd");
document.addEventListener('DOMContentLoaded', function() {
  var imageIndex = 0;
  var imageContainer = document.getElementById('fullscreen-images');

  function loadImage() {
    if(imageIndex == 1){
      var imageUrl = "/correct.png";
    }
    else{
      var imageUrl = "/wrong.png";
    }
    var img = document.createElement('img');
    img.src = imageUrl;

    imageContainer.innerHTML = '';
    imageContainer.appendChild(img);
  }

  window.addEventListener('resize', function() {
    loadImage();
  });

  document.addEventListener('click', function() {
    imageIndex++;
    loadImage();
  });

  // 画面初期表示時に最初の画像をロードします
  loadImage();
});