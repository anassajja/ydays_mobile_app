import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart'; // Import the home page
import '../services/voting_service.dart'; // Import the VotingService

class ConfirmationScreen extends StatefulWidget {
  final String electionId;
  final String voterId;
  final String candidateId;

  const ConfirmationScreen({super.key, required this.electionId, required this.voterId, required this.candidateId});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final VotingService _votingService = VotingService(baseUrl: 'http://localhost:5006');
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _confirmVote() async {
    try {
      // Here you can add additional password verification if needed
      final success = await _votingService.castVote(widget.electionId, widget.voterId, widget.candidateId);
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map candidate names to images
    final Map<String, String> candidateImages = {
      'Biden': 'assets/biden.png',
      'Trump': 'assets/trump.png',
      'Obama': 'assets/obama.png',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Your Vote'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the home page when the logo is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/evote.svg', // Ensure the path to the logo is correct
                  height: 100.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Vote for',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                candidateImages[widget.candidateId]!,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                widget.candidateId,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.blue),
                  hintText: 'Enter your password',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20), // Added space between the password field and button
              ElevatedButton(
                onPressed: _confirmVote,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20), backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
