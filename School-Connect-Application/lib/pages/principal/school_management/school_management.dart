import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SchoolManagement extends StatefulWidget {
  const SchoolManagement({super.key});

  @override
  State<SchoolManagement> createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  bool isLoading = false;
  late HttpService http;
  School school = School();
  @override
  void initState() {
    http = HttpService();
    getSchools("School/GetSchoolById?schoolId=");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay with content
          Container(
            width: screenSize.width,
            height: screenSize.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7), // Transparency
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    const Icon(Icons.person,
                        size: 100, color: Color(0xFF0F2E34)),
                    const SizedBox(height: 20),
                    // Name
                    Text(
                      '${school.name} ${school.type} School',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: _buildButton(context, 'View School Info',
                          RouteManagerProvider.principalUpdateSchool),
                    ),
                    const SizedBox(height: 50),
                    _buildButton(context, 'Manage Teacher Class Assignment',
                        RouteManagerProvider.principalAssignTeacherToClass),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Manage Announcement Groups',
                        RouteManagerProvider.principalListAnnounce),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Manage School',
                        RouteManagerProvider.principalListAnnounce),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Manage Grades',
                        RouteManagerProvider.manageGrades),
                    const SizedBox(height: 40),
                    // Logout Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        width: screenSize.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.8),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build buttons
  Widget _buildButton(BuildContext context, String text, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  // Get School information
  Future<void> getSchools(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    setState(() {
      isLoading = true;
    });

    try {
      log("Fetching schools");

      // Making the API request
      Response response = await http.getRequest("${http.baseUrl}$url$token");
      log("School response code: ${response.statusCode}");

      // Debugging: Print the entire response to verify its structure
      log("Response data: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data;

        // Check if result['Result'] exists and is a Map
        if (result['Success'] == true && result['Result'] != null) {
          var schoolData = result['Result'];

          // Debugging: Print the schoolData to verify the content
          log("Parsed school data: $schoolData");

          setState(() {
            school = School.fromJson(schoolData);

            log("School name: ${school.name}");
          });
          if (school == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("Could not find a school linked to this admin's ID")));
          }
        } else {
          log("Unexpected response format or 'Success' is false");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response format')),
          );
        }
      } else {
        log("Problem, statusCode: ${response.statusCode}, message: ${response.statusMessage}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to load schools: ${response.statusMessage}')),
        );
      }
    } on DioException catch (e) {
      log("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load schools: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
