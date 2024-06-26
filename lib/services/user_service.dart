// lib/services/user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  UserService({required this.baseUrl});

  Future<List<dynamic>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

// Add more methods for other user endpoints as needed
}
