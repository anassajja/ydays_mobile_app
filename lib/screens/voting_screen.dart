// lib/screens/voting_screen.dart

import 'package:flutter/material.dart';
import 'confirmation_screen.dart'; // Import the confirmation screen
import 'more_info_screen.dart'; // Import the more info screen
import '../services/candidate_service.dart'; // Import the CandidateService
// Import the VotingService

class VotingScreen extends StatefulWidget {
  final String electionId;
  final String voterId;

  const VotingScreen({super.key, required this.electionId, required this.voterId});

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String selectedCandidateId = '';
  final CandidateService _candidateService = CandidateService(baseUrl: 'http://localhost:5004');
  late Future<List<dynamic>> _candidates;

  @override
  void initState() {
    super.initState();
    _candidates = _candidateService.getCandidatesByElection(widget.electionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vote for Your Candidate'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
          future: _candidates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No candidates found'));
            } else {
              final candidates = snapshot.data!;
              if (selectedCandidateId.isEmpty) {
                selectedCandidateId = candidates.first['id']; // Assuming the candidate object has an 'id' field
              }
              return Column(
                children: [
                  // Dropdown for selecting a candidate
                  DropdownButtonFormField<String>(
                    value: selectedCandidateId,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCandidateId = newValue!;
                      });
                    },
                    items: candidates.map<DropdownMenuItem<String>>((candidate) {
                      return DropdownMenuItem<String>(
                        value: candidate['id'],
                        child: Text(candidate['name']),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // List of candidates
                  Expanded(
                    child: ListView.builder(
                      itemCount: candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = candidates[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  candidate['image_url'],
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        candidate['name'],
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        candidate['description'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedCandidateId = candidate['id'];
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            child: const Text('Vote'),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Navigate to more info screen
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MoreInfoScreen(
                                                    candidateName: candidate['name'],
                                                    candidateImage: candidate['image_url'],
                                                    candidateDetails: candidate['details'],
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blueGrey,
                                            ),
                                            child: const Text('More info'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: selectedCandidateId == candidate['id'],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedCandidateId = candidate['id'];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the confirmation screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(
                            electionId: widget.electionId,
                            voterId: widget.voterId,
                            candidateId: selectedCandidateId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      backgroundColor: Colors.teal[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
