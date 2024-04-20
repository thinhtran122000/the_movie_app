import 'package:tmdb/models/models.dart';

class MediaCredits {
  List<CreditResult> cast;
  List<CreditResult> crew;

  MediaCredits({
    this.cast = const [],
    this.crew = const [],
  });

  factory MediaCredits.fromJson(Map<String, dynamic> json) => MediaCredits(
        cast: json['cast'] == null
            ? []
            : List<CreditResult>.from(json['cast'].map((x) => CreditResult.fromJson(x))),
        crew: json['crew'] == null
            ? []
            : List<CreditResult>.from(json['crew'].map((x) => CreditResult.fromJson(x))),
      );
}
