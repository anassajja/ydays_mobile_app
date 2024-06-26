// lib/services/election_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ElectionService {
  final String baseUrl;

  ElectionService({required this.baseUrl});

  Future<List<dynamic>> getAllElections() async {
    final response = await http.get(Uri.parse('$baseUrl/api/elections/all'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load elections');
    }
  }

  Future<Map<String, dynamic>> getElectionById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/elections/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load election');
    }
  }

// Add more methods for other API endpoints as needed
}
