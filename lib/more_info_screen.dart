import 'package:flutter/material.dart';

class MoreInfoScreen extends StatelessWidget {
  final String candidateName;
  final String candidateImage;
  final String candidateDetails;

  MoreInfoScreen({
    required this.candidateName,
    required this.candidateImage,
    required this.candidateDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidateName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                candidateImage,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              candidateName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              candidateDetails,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
