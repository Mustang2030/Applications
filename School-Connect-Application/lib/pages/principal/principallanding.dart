import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class PrincipalLandingPage extends StatefulWidget {
  const PrincipalLandingPage({super.key});

  @override
  State<PrincipalLandingPage> createState() => _PrincipalLandingPageState();
}

class _PrincipalLandingPageState extends State<PrincipalLandingPage> {
  bool isLoading = false;
  late HttpService http;
  Principal principal = Principal();
  School school = School();
  @override
  void initState() {
    http = HttpService();
    getUser("Principal/GetPrincipalById?id=");
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
                      'Welcome ${principal.title} ${principal.name} ${principal.surname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Buttons
                    _buildButton(context, 'View Profile',
                        RouteManagerProvider.viewProfile),
                    const SizedBox(height: 15),
                    _buildButton(context, 'Make Announcements',
                        RouteManagerProvider.makeAnnouncements),
                    const SizedBox(height: 15),
                    _buildButton(context, 'View Announcements',
                        RouteManagerProvider.viewAnnouncements),
                    const SizedBox(height: 15),
                    _buildButton(
                        context, 'Grades', RouteManagerProvider.gradeView),
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
                            'LOGOUT',
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

  Future<void> getUser(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Role registration page');
    log('current token $token');
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            principal = Principal.fromJson(result);

            // Set values to controllers after data is fetched

            log("Mapped SystemAdmin: Name: ${principal.name}, Email: ${principal.emailAddress}, School Name: ${principal.principalSchoolNP!.name}");
            isLoading = false;
          });
        }
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
