import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/pages/parent/parentViewAttendance.dart';
import 'package:scs/pages/parent/parentViewReports.dart';

// Import your page classes
import '../communication/view_announcements.dart';
// Replace with your actual page file

class ChildProfilePage extends StatelessWidget {
  const ChildProfilePage({super.key});

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
            color: kTextColor,
            size: 25,
          ),
        ),
        title: const Text(
          'Child Profile',
          style: TextStyle(color: kTextColor),
        ),
        backgroundColor: const Color(0xFF0F2E34),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildProfileInfo(),
                const SizedBox(height: 30),
                _buildDetailsBox(),
                _buildActionButtons(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
          _buildChatButton(), // Chat button positioned separately
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(
            FontAwesomeIcons.user,
            size: 120,
            color: Color(0xFF0F2E34),
          ),
          const SizedBox(height: 10),
          const Text(
            'Thembile Poti',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Grade 10B',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CLASS TEACHER: KGOPOLO MOOI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          const Text(
            'SUBJECTS:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          _buildSubjectList(),
        ],
      ),
    );
  }

  Widget _buildSubjectList() {
    List<String> subjects = [
      'MATHEMATICS',
      'PHYSICS',
      'ENGLISH HL',
      'XHOSA FAL',
      'GEOGRAPHY',
      'LIFE ORIENTATION'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: subjects.map((subject) {
        return Text(subject, style: const TextStyle(fontSize: 16));
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(context, 'ANNOUNCEMENTS', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnnouncementsPage()),
          );
        }),
        _buildActionButton(context, 'REPORT', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProgressReportScreen()),
          );
        }),
        _buildActionButton(context, 'ATTENDANCE', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendanceRecordPage()),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: onPressed, // Call the onPressed function passed
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F2E34),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildChatButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to chat page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ChatPage()), // Replace with actual Chat page
            // );
          },
          backgroundColor: const Color(0xFFD3D3D3),
          child: const Icon(
            FontAwesomeIcons.comments,
            size: 30,
            color: Color(0xFF0F2E34),
          ),
        ),
      ),
    );
  }
}
