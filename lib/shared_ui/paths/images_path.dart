enum ImagesPath {
  corgi('lib/shared_ui/assets/images/corgi.jpg'),
  background('lib/shared_ui/assets/images/background.png'),
  noImage('lib/shared_ui/assets/images/no_image.png'),
  noImageMan('lib/shared_ui/assets/images/no_image_man.png'),
  noImageWoman('lib/shared_ui/assets/images/no_image_woman.png'),
  noImageOtherGender('lib/shared_ui/assets/images/no_image_other_gender.png'),
  tmdbPrimaryShort('lib/shared_ui/assets/images/tmdb_primary_short.svg');

  const ImagesPath(this.assetName);
  final String assetName;
}
