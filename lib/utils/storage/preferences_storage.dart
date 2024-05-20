import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorage {
  static final PreferencesStorage _instance = PreferencesStorage._();
  PreferencesStorage._();
  factory PreferencesStorage() => _instance;
  static SharedPreferences? sharedPreferences;
  static Future<SharedPreferences> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> setBool(String key, bool value) async =>
      await sharedPreferences!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await sharedPreferences!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await sharedPreferences!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await sharedPreferences!.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await sharedPreferences!.setStringList(key, value);

  static bool? getBool(String key) => sharedPreferences!.getBool(key);

  static double? getDouble(String key) => sharedPreferences!.getDouble(key);

  static int? getInt(String key) => sharedPreferences!.getInt(key);

  static String? getString(String key) => sharedPreferences!.getString(key);

  static List<String>? getStringList(String key) => sharedPreferences!.getStringList(key);

  static Future<bool> remove(String key) async => await sharedPreferences!.remove(key);

  static Future<bool> clear() async => await sharedPreferences!.clear();
}
