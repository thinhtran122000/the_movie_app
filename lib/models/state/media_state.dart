import 'package:tmdb/models/state/state.dart';

class MediaState {
  int? id;
  bool? favorite;
  dynamic rated;
  bool? watchlist;

  MediaState({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory MediaState.fromJson(Map<String, dynamic> json) {
    dynamic ratedValue = json['rated'];
    if (ratedValue is bool) {
      return MediaState(
        id: json['id'],
        favorite: json['favorite'],
        rated: false,
        watchlist: json['watchlist'],
      );
    } else if (ratedValue is Map<String, dynamic>) {
      return MediaState(
        id: json['id'],
        favorite: json['favorite'],
        rated: Rated.fromJson(json['rated']),
        watchlist: json['watchlist'],
      );
    } else {
      throw const FormatException("Invalid 'rated' value");
    }
  }
}
