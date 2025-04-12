// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Provided Directus API URL
  static const String _baseUrl = 'https://api.fluttercrypto.agpro.co.in';

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': 'bf6c3d87-3564-43ac-a172-5614bbc40811',
        'first_name': name,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Sign-up error: ${response.body}');
      return false;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['data']['access_token'];
      await secureStorage.write(key: 'token', value: token);
      return token;
    } else {
      print('Login error: ${response.body}');
      return null;
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }
}
