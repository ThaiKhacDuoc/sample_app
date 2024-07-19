document.addEventListener("turbo:load", function() {
  const imageUpload = document.querySelector('#micropost_image');

  document.addEventListener("change", function(event) {
    if (imageUpload && imageUpload.files[0]) {
      const sizeInMegabytes = imageUpload.files[0].size / 1024 / 1024;
      if (sizeInMegabytes > 5) {
        alert(I18n.t("micropost.create.image_size_alert"));
        imageUpload.value = "";
      }
    }
  });
});
