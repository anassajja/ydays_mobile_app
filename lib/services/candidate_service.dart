// lib/services/candidate_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class CandidateService {
  final String baseUrl;

  CandidateService({required this.baseUrl});

  Future<List<dynamic>> getCandidatesByElection(String electionId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/candidates/$electionId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load candidates');
    }
  }
}
