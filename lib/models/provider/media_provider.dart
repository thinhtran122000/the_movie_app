import 'package:tmdb/models/provider/provider.dart';

class MediaProvider {
  DisplayPriorities? displayPriorities;
  int? displayPriority;
  String? logoPath;
  String? providerName;
  int? providerId;

  MediaProvider({
    required this.displayPriorities,
    required this.displayPriority,
    required this.logoPath,
    required this.providerName,
    required this.providerId,
  });

  factory MediaProvider.fromJson(Map<String, dynamic> json) => MediaProvider(
        displayPriorities: json['display_priorities'] == null
            ? null
            : DisplayPriorities.fromJson(json['display_priorities']),
        displayPriority: json['display_priority'],
        logoPath: json['logo_path'],
        providerName: json['provider_name'],
        providerId: json['provider_id'],
      );
}
