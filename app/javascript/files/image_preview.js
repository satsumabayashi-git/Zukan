// alert("test.js読み込み");

document.addEventListener("turbo:load", function() {
  const preview = document.getElementById("preview-area");
  const fileInput = document.getElementById("post_image") || document.getElementById("user_profile_image");

  console.log("読み込み完了");
  fileInput.addEventListener("change", previewFile);

  function previewFile() {
    const file = fileInput.files[0];
    const reader = new FileReader();

    reader.addEventListener("load", () => {
      preview.style.backgroundImage = `url(${reader.result})`;
      preview.style.width = "200px";
      preview.style.height = "200px";
    });

    if (file) {
      reader.readAsDataURL(file);
    }
  }
})

/*
window.onload = function(){
  const preview = document.getElementById("preview-area");
  const fileInput = document.getElementById("post_image") || document.getElementById("user_profile_image");

  console.log("読み込み完了");
  fileInput.addEventListener("change", previewFile);

  function previewFile() {
    const file = fileInput.files[0];
    const reader = new FileReader();

    reader.addEventListener("load", () => {
      preview.style.backgroundImage = `url(${reader.result})`;
      preview.style.width = "200px";
      preview.style.height = "200px";
    });

    if (file) {
      reader.readAsDataURL(file);
    }
  }
}
  */
