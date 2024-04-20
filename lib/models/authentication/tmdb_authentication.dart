class TmdbAuthentication {
  bool? success;
  bool? failure;
  int? statusCode;
  String? statusMessage;
  String? expiresAt;
  String? requestToken;

  TmdbAuthentication({
    this.success,
    this.failure,
    this.statusCode,
    this.statusMessage,
    this.expiresAt,
    this.requestToken,
  });

  factory TmdbAuthentication.fromJson(Map<String, dynamic> json) => TmdbAuthentication(
        success: json['success'],
        failure: json['failure'],
        statusCode: json['status_code'],
        statusMessage: json['status_message'],
        expiresAt: json['expires_at'],
        requestToken: json['request_token'],
      );
}
