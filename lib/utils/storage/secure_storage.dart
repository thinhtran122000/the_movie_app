import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._();
  SecureStorage._();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  factory SecureStorage() => _instance;
  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<String?> getValue(String requestTokenKey) async {
    return await secureStorage.read(key: requestTokenKey);
  }

  Future<void> setValue(String requestTokenKey, String requestToken) async {
    return await secureStorage.write(key: requestTokenKey, value: requestToken);
  }

  Future<void> deleteValue(String requestTokenKey) async {
    return await secureStorage.delete(key: requestTokenKey);
  }

  Future<void> deleteAllValues() async {
    return await secureStorage.deleteAll();
  }

  Future<Map<String, String>> getAllValues() async {
    return await secureStorage.readAll();
  }

  Future<bool> checkValue(String requestTokenKey) async {
    return await secureStorage.containsKey(key: requestTokenKey);
  }
}
