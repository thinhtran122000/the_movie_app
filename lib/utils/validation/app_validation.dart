import 'package:intl/intl.dart';

class AppValidation {
  static final AppValidation _instance = AppValidation._();
  AppValidation._();
  factory AppValidation() => _instance;

  String validateAccount(String username, String password) {
    if (username.trim().isEmpty && password.trim().isEmpty) {
      return 'Please provide your username\nPlease enter your password';
    } else if (username.trim().isEmpty) {
      return 'Please provide your username';
    } else if (password.trim().isEmpty) {
      return 'Please enter your password';
    } else {
      return '';
    }
  }

  bool isExpired(String expiresAt) {
    DateTime now = DateTime.now().toLocal();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    //get string exception 'UTC' and parse UTC
    DateTime formatExpiresAt = dateFormat.parseUTC(expiresAt.substring(0, 19)).toLocal();
    // check if today is after the expires date
    return now.isAtSameMomentAs(formatExpiresAt) || now.isAfter(formatExpiresAt);
  }
}
