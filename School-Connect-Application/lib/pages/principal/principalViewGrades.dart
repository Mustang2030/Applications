import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/pages/principal/principlaGradeLanding.dart';

class ViewGradeOverviewPage extends StatelessWidget {
  const ViewGradeOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Back button color
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: const Text(
          "Principal's Grade Overview",
          style: TextStyle(color: kTextColor), // Title color
        ),
        centerTitle: true, // Center the title
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildGradeSection(context, "Grade 8", ["8A", "8B"]),
            _buildGradeSection(context, "Grade 9", ["9A", "9B"]),
            _buildGradeSection(context, "Grade 10", ["10A", "10B"]),
            _buildGradeSection(context, "Grade 11", ["11A", "11B"]),
            _buildGradeSection(context, "Grade 12", ["12A", "12B"]),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeSection(
      BuildContext context, String grade, List<String> classes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            grade,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: classes.map((className) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0F2E34), // Button background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15), // Increased padding for larger buttons
                    textStyle: const TextStyle(
                      color: kTextColor, // White color for text
                      fontSize: 25,
                    ), // Increased font size for better visibility
                  ),
                  onPressed: () {
                    // Navigate to the corresponding page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => principalGradeLandingPage(),
                      ),
                    );
                  },
                  child: Text(className),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
