import 'package:tmdb/models/state/state.dart';

class MediaState {
  int? id;
  bool? favorite;
  bool? rated;
  bool? watchlist;

  MediaState({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory MediaState.fromJson(Map<String, dynamic> json) => MediaState(
        id: json['id'],
        favorite: json['favorite'],
        rated: json['rated'] ? Rated.fromJson(json['rated']) : json['rated'],
        watchlist: json['watchlist'],
      );
}
