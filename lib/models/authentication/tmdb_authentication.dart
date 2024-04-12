class TmdbAuthentication {
  bool? success;
  int? statusCode;
  String? statusMessage;
  String? expiresAt;
  String? requestToken;

  TmdbAuthentication({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
    required this.expiresAt,
    required this.requestToken,
  });

  factory TmdbAuthentication.fromJson(Map<String, dynamic> json) => TmdbAuthentication(
        success: json['success'],
        statusCode: json['status_code'],
        statusMessage: json['status_message'],
        expiresAt: json['expires_at'],
        requestToken: json['request_token'],
      );
}
