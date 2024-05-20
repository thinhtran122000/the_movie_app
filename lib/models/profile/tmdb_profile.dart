import 'package:tmdb/models/profile/profile.dart';

class TmdbProfile {
  Avatar? avatar;
  int? id;
  String? iso6391;
  String? iso31661;
  String? name;
  bool? includeAdult;
  String? username;

  TmdbProfile({
    this.avatar,
    this.id,
    required this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  factory TmdbProfile.fromJson(Map<String, dynamic> json) => TmdbProfile(
        avatar: json['avatar'] == null ? null : Avatar.fromJson(json['avatar']),
        id: json['id'],
        iso6391: json['iso_639_1'],
        iso31661: json['iso_3166_1'],
        name: json['name'],
        includeAdult: json['include_adult'],
        username: json['username'],
      );
}
