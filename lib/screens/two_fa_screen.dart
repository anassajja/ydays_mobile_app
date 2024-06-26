// lib/screens/two_fa_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';
import 'election_categories_screen.dart';
import '../services/two_fa_service.dart';

class TwoFAScreen extends StatefulWidget {
  final String userId;

  const TwoFAScreen({super.key, required this.userId});

  @override
  _TwoFAScreenState createState() => _TwoFAScreenState();
}

class _TwoFAScreenState extends State<TwoFAScreen> {
  final TwoFAService _twoFAService = TwoFAService(baseUrl: 'http://localhost:5001');
  final TextEditingController _codeController = TextEditingController();
  String _errorMessage = '';

  Future<void> _verifyCode() async {
    try {
      final isValid = await _twoFAService.verifyCode(widget.userId, _codeController.text);
      if (isValid) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ElectionCategoriesScreen()),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('2FA Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Center(
                  child: SvgPicture.asset(
                    'assets/evote.svg',
                    height: 100.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter 2FA Code',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '2FA Code',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  hintText: 'Enter the 2FA code',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Handle link tap
                  },
                  child: const Text(
                    'didn’t receive the code ?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _verifyCode,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    backgroundColor: Colors.teal[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
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
