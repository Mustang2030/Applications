import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scs/consts/constans.dart';

class ParentSchoolProfile extends StatelessWidget {
  static const routeName = '/parent-school-profile';

  const ParentSchoolProfile({super.key}); // Named route

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F2E34), // Match the header color
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: Text(
          'Harmonia Combined'.toUpperCase(), // Convert text to uppercase
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF8F8FF),
        child: Column(
          children: [
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Image
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'images/harmonia.jpg', // Change path as needed
                          width: double.infinity,
                          height: 200, // Adjust height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Profile List
                    Column(
                      children: [
                        // Child Profile Button 1
                        ProfileButton(
                          name: 'Thembile Poti',
                          onPressed: () {
                            // Navigate to ParentViewChildProfile for Thembile
                            Navigator.pushNamed(
                                context, 'parent_view_child_prof',
                                arguments: 'Thembile Poti');
                          },
                        ),
                        SizedBox(
                            height: 15.0), // Reduced height for better spacing
                        ProfileButton(
                          name: 'Omphile Poti',
                          onPressed: () {
                            // Navigate to ParentViewChildProfile for Omphile
                            Navigator.pushNamed(
                                context, 'parent-view-child-profile',
                                arguments: 'Omphile Poti');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const ProfileButton({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0F2E34),
        foregroundColor: Color(0xFFF8F8FF),
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(double.infinity, 50), // Full width
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Align items to the start
        children: [
          FaIcon(FontAwesomeIcons.user, color: Color(0xFFF8F8FF), size: 25),
          SizedBox(width: 20), // Spacing between icon and text
          Expanded(
            // Make the text take the remaining space
            child: Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          FaIcon(
            FontAwesomeIcons.arrowRight,
            color: Color(0xFFF8F8FF),
            size: 20,
          ),
        ],
      ),
    );
  }
}
