import 'package:intl/intl.dart';

class JwtDecoder {
  static bool isExpired(String expiresAt) {
    DateTime now = DateTime.now().toUtc();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    //get string exception 'UTC' and parse UTC
    DateTime formatExpiresAt = dateFormat.parseUTC(expiresAt.substring(0, 19));
    // check if today is after the expires date
    return now.isAtSameMomentAs(formatExpiresAt) || now.isAfter(formatExpiresAt);
    // return now.isAtSameMomentAs(now) || now.isAfter(now);
  }
}
