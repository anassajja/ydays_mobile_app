// lib/services/voting_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class VotingService {
  final String baseUrl;

  VotingService({required this.baseUrl});

  Future<bool> castVote(String electionId, String voterId, String candidateId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/votes/$electionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': voterId,
        'candidateId': candidateId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cast vote');
    }
  }
}
