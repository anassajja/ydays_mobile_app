// lib/services/two_fa_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class TwoFAService {
  final String baseUrl;

  TwoFAService({required this.baseUrl});

  Future<bool> verifyCode(String userId, String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/verify-2fa'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to verify 2FA code');
    }
  }
}
