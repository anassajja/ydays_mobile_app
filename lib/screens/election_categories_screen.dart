// lib/screens/election_categories_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/election_service.dart';
import 'main.dart';
import 'voting_screen.dart';

class ElectionCategoriesScreen extends StatefulWidget {
  const ElectionCategoriesScreen({super.key});

  @override
  State<ElectionCategoriesScreen> createState() => _ElectionCategoriesScreenState();
}

class _ElectionCategoriesScreenState extends State<ElectionCategoriesScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  late Future<List<dynamic>> _elections;
  final ElectionService _electionService = ElectionService(baseUrl: 'http://localhost:5003');

  @override
  void initState() {
    super.initState();
    _elections = _electionService.getAllElections();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _onArrowTap(int increment) {
    _pageController.animateToPage(
      currentPage + increment,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _elections,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No elections found'));
          } else {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the home page when the logo is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/evote.svg',
                            height: 90.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Elections',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: _onPageChanged,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final election = snapshot.data![index];
                            return buildElectionCategoryCard(
                              context,
                              election['name'],
                              'assets/election.png', // Update this with the correct image path if available
                              election['startDate'],
                              election['endDate'],
                              election['createdAt'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16.0,
                  top: MediaQuery.of(context).size.height / 2,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: currentPage > 0 ? () => _onArrowTap(-1) : null,
                  ),
                ),
                Positioned(
                  right: 16.0,
                  top: MediaQuery.of(context).size.height / 2,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 30),
                    onPressed: currentPage < snapshot.data!.length - 1 ? () => _onArrowTap(1) : null,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildElectionCategoryCard(BuildContext context, String title, String imagePath, String startDate, String endDate, String createdAt) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: InkWell(
          onTap: () {
            // Navigate to the voting screen when a category is selected
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VotingScreen(electionId: '', voterId: '',)),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7, // Adjust the width as needed
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    imagePath,
                    height: 100.0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text('Start Date: $startDate', textAlign: TextAlign.center),
                Text('End Date: $endDate', textAlign: TextAlign.center),
                Text('Created At: $createdAt', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
