import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Stack(
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
                      'assets/logo.svg',
                      height: 100.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Elections',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      buildElectionCategoryCard(context, 'Élection municipale', 'assets/election1.png', '01/08/2024', '16/08/2024', '19/06/2024'),
                      buildElectionCategoryCard(context, 'Élection C', 'assets/election2.png', '01/07/2024', '16/07/2024', '19/06/2024'),
                      buildElectionCategoryCard(context, 'Élection D', 'assets/election3.png', '01/07/2024', '16/07/2024', '19/06/2024'),
                      // Add more categories here as needed
                    ],
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
              onPressed: currentPage < 2 ? () => _onArrowTap(1) : null,
            ),
          ),
        ],
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
              MaterialPageRoute(builder: (context) => const VotingScreen()),
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
