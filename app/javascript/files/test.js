const preview = document.getElementById("preview-area");
const fileInput = document.getElementById("post_image") || document.getElementById("user_profile_image");

window.onload = function(){
  alert("読み込み完了");
  console.log("読み込み完了");
  fileInput.addEventListener("change", previewFile);
}

console.log("読み込み完了");

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

function DeleteCheck(type){
  switch (type) {
    case 'post':
      var message = "投稿を削除しますか？";
      break;
    case 'comment':
      var message = "コメントを削除しますか？";
      break;
    case 'logout':
      var message = "ログアウトしますか？";
      break;
    case 'user':
      var message = "アカウントを削除しますか？";
      break;
    default:
  }

  if(window.confirm(message)){ 
    return true;
  }
  else{
    window.alert('キャンセルされました'); 
    return false; 
  }
}