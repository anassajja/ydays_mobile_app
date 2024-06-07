import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart'; // Import the home page

class ConfirmationScreen extends StatelessWidget {
  final String candidate;

  ConfirmationScreen({required this.candidate});

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
        title: Text('Confirm Your Vote'),
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
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/logo.svg', // Ensure the path to the logo is correct
                  height: 80.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Vote for',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                candidateImages[candidate]!,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                candidate,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
              ),
              SizedBox(height: 20), // Added space between the password field and button
              ElevatedButton(
                onPressed: () {
                  // Handle vote confirmation
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20), backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
