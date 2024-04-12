enum AnimationsPath {
  loadingAnimation('lib/shared_ui/assets/animations/loading_animation.json'),
  pandaWalkAnimation('lib/shared_ui/assets/animations/panda_walk_animation.json'),
  pandaSleepAnimation('lib/shared_ui/assets/animations/panda_sleep_animation.json');

  const AnimationsPath(this.assetName);
  final String assetName;
}
