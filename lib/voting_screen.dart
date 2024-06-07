import 'package:flutter/material.dart';
import 'confirmation_screen.dart'; // Import the confirmation screen
import 'more_info_screen.dart'; // Import the more info screen

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String selectedCandidate = 'Trump';

  final List<Map<String, String>> candidates = [
    {
      'name': 'Biden',
      'description': 'Biden is an American politician, media personality...',
      'image': 'assets/biden.png',
      'details': '45th President of the United States In office ...' // Example details
    },
    {
      'name': 'Trump',
      'description': 'Donald John Trump is an American politician, media personality...',
      'image': 'assets/trump.png',
      'details': '45th President of the United States In office ...' // Example details
    },
    {
      'name': 'Obama',
      'description': 'Obama is an American politician, media personality...',
      'image': 'assets/obama.png',
      'details': '44th President of the United States In office ...' // Example details
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vote for Your Candidate'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for selecting a candidate
            DropdownButtonFormField<String>(
              value: selectedCandidate,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCandidate = newValue!;
                });
              },
              items: candidates.map<DropdownMenuItem<String>>((candidate) {
                return DropdownMenuItem<String>(
                  value: candidate['name'],
                  child: Text(candidate['name']!),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
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
                          Image.asset(
                            candidate['image']!,
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  candidate['name']!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  candidate['description']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedCandidate = candidate['name']!;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: Text('Vote'),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigate to more info screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MoreInfoScreen(
                                              candidateName: candidate['name']!,
                                              candidateImage: candidate['image']!,
                                              candidateDetails: candidate['details']!,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      child: Text('More info'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Checkbox(
                            value: selectedCandidate == candidate['name'],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedCandidate = candidate['name']!;
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
            SizedBox(height: 20),
            // Continue button
            ElevatedButton(
              onPressed: () {
                // Navigate to the confirmation screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(candidate: selectedCandidate),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20), backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
