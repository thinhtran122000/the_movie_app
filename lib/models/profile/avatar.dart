import 'package:tmdb/models/profile/profile.dart';

class Avatar {
  Gravatar? gravatar;
  Tmdb? tmdb;

  Avatar({
    this.gravatar,
    this.tmdb,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        gravatar: json['gravatar'] == null ? null : Gravatar.fromJson(json['gravatar']),
        tmdb: json['tmdb'] == null ? null : Tmdb.fromJson(json['tmdb']),
      );
}
