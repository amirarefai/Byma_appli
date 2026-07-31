import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create a single, private instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Key used to save and retrieve the token
  static const String _tokenKey = 'auth_token';

  /// Saves the JWT token securely to the device
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieves the JWT token from secure storage
  /// Returns null if no token exists
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Deletes the JWT token (used for logout or 401 Unauthorized)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// Optional: Clears all secure storage data (useful for a complete factory reset/logout)
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Optional: Checks if a user is currently logged in by verifying token existence
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}