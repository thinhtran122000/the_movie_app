class Tmdb {
  String? avatarPath;

  Tmdb({
    this.avatarPath,
  });

  factory Tmdb.fromJson(Map<String, dynamic> json) => Tmdb(
        avatarPath: json['avatar_path'],
      );
}
