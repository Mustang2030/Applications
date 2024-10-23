import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';

class principalGradeLandingPage extends StatelessWidget {
  const principalGradeLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
              color: kTextColor,
            )),
        title: const Text(
          'Teacher Profile',
          style: TextStyle(color: kTextColor),
        ),
        backgroundColor: const Color(0xFF0F2E34), // Dark green header
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildProfileInfo(),
                const SizedBox(height: 30),
                _buildDetailsBox(),
                const SizedBox(height: 20),
                _buildActionButton(context, 'View Attendance', onPressed: () {
                  // Navigate to attendance screen
                }),
                _buildActionButton(context, 'View Report', onPressed: () {
                  // Navigate to report screen
                }),
              ],
            ),
          ),
        ),
      ),
      backgroundColor:
          Colors.grey[200], // Background color similar to ghostwhite
    );
  }

  Widget _buildProfileInfo() {
    return const Column(
      children: [
        Icon(
          Icons.person,
          size: 100,
          color: Color(0xFF0F2E34), // Dark green icon
        ),
        SizedBox(height: 10),
        Text(
          'Kgopolo Mooi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CLASS TEACHER: 10B',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'SUBJECTS TAUGHT:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text('MATHEMATICS'),
          Text('GEOGRAPHY'),
          Text('LIFE ORIENTATION'),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text,
      {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF0F2E34), // White text color
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(300, 50),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
