import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorage {
  static final FlutterStorage _instance = FlutterStorage._();
  FlutterStorage._();
  factory FlutterStorage() => _instance;

  final FlutterSecureStorage _flutterStorage = const FlutterSecureStorage();
  FlutterSecureStorage get flutterStorage => _flutterStorage;

  Future<String?> getValue(String key) async => await flutterStorage.read(key: key);

  Future<void> setValue(String key, String value) async =>
      await flutterStorage.write(key: key, value: value);

  Future<void> deleteValue(String key) async {
    return await flutterStorage.delete(key: key);
  }

  Future<void> deleteAllValues() async {
    return await flutterStorage.deleteAll();
  }

  Future<Map<String, String>> getAllValues() async {
    return await flutterStorage.readAll();
  }

  Future<bool> checkValue(String key) async {
    return await flutterStorage.containsKey(key: key);
  }
}
