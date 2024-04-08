enum ImagesPath {
  corgi('lib/shared_ui/assets/images/corgi.jpg'),
  background('lib/shared_ui/assets/images/background.png'),
  logoAppImage('lib/shared_ui/assets/images/logo_app_image.svg'),
  noImage('lib/shared_ui/assets/images/no_image.png'),
  noImageMan('lib/shared_ui/assets/images/no_image_man.png'),
  noImageWoman('lib/shared_ui/assets/images/no_image_woman.png'),
  noImageOtherGender('lib/shared_ui/assets/images/no_image_other_gender.png');

  const ImagesPath(this.assetName);
  final String assetName;
}
