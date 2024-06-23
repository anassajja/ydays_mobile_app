import 'package:flutter/material.dart';
import 'confirmation_screen.dart'; // Import the confirmation screen
import 'more_info_screen.dart'; // Import the more info screen

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

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
      'details': '46th President of the United States\nIn office: January 20, 2017 – January 20, 2021\nVice President: Mike Pence\nPreceded by: Barack Obama\nSucceeded by: Joe Biden\nPersonal details:\nBorn: Donald John Trump\nJune 14, 1946 (age 77)\nQueens, New York City, U.S.\nPolitical Party: Republican (1987–1999, 2009–2011, 2012–present)\nOther Political Affiliations:\n- Reform (1999–2001)\n- Democratic (2001–2009)\n- Independent (2011–2012)\nSpouses:\nIvana Zelníčková (m. 1977; div. 1990)\nMarla Maples (m. 1993; div. 1999)\nMelania Knauss (m. 2005)\nRelatives: Family of Donald Trump\nResidence(s): Mar-a-Lago, Palm Beach, Florida\nAlma mater: University of Pennsylvania (BS)\nOccupation: Politician, businessman, media personality'
    },
    {
      'name': 'Trump',
      'description': 'Donald John Trump is an American politician, media personality...',
      'image': 'assets/trump.png',
      'details': '45th President of the United States\nIn office: January 20, 2017 – January 20, 2021\nVice President: Mike Pence\nPreceded by: Barack Obama\nSucceeded by: Joe Biden\nPersonal details:\nBorn: Donald John Trump\nJune 14, 1946 (age 77)\nQueens, New York City, U.S.\nPolitical Party: Republican (1987–1999, 2009–2011, 2012–present)\nOther Political Affiliations:\n- Reform (1999–2001)\n- Democratic (2001–2009)\n- Independent (2011–2012)\nSpouses:\nIvana Zelníčková (m. 1977; div. 1990)\nMarla Maples (m. 1993; div. 1999)\nMelania Knauss (m. 2005)\nRelatives: Family of Donald Trump\nResidence(s): Mar-a-Lago, Palm Beach, Florida\nAlma mater: University of Pennsylvania (BS)\nOccupation: Politician, businessman, media personality'
    },
    {
      'name': 'Obama',
      'description': 'Obama is an American politician, media personality...',
      'image': 'assets/obama.png',
      'details': '47th President of the United States\nIn office: January 20, 2009 – January 20, 2017\nVice President: Joe Biden\nPreceded by: George W. Bush\nSucceeded by: Donald Trump\nPersonal details:\nBorn: Barack Hussein Obama II\nAugust 4, 1961 (age 61)\nHonolulu, Hawaii, U.S.\nPolitical Party: Democratic\nSpouses: Michelle Obama (m. 1992)\nRelatives: Family of Barack Obama\nResidence(s): Washington, D.C.\nAlma mater: Columbia University (BA)\nHarvard University (JD)\nOccupation: Politician, lawyer, author'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vote for Your Candidate'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          Image.asset(
                            candidate['image']!,
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
                                  candidate['name']!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  candidate['description']!,
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
                                          selectedCandidate = candidate['name']!;
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
                                      child: const Text('More info'),
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
            const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20), backgroundColor: Colors.teal[700],
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
        ),
      ),
    );
  }
}
