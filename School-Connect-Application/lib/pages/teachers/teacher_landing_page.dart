import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class TeacherP extends StatefulWidget {
  const TeacherP({super.key});

  @override
  State<TeacherP> createState() => _TeacherPState();
}

class _TeacherPState extends State<TeacherP> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getTeacher("Teacher/GetTeacherById?id=");
    super.initState();
  }

  Teacher teacher = Teacher();
  Parent parent = Parent();
  Learner learner = Learner(parents: []);
  Principal principal = Principal();
  School school = School();
  bool isLoading = false;
  List<String> subjects = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                              size: 100, color: Color.fromARGB(255, 2, 23, 27)),
                          const SizedBox(height: 20),
                          Text(
                            '${teacher.role}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Name
                          Text(
                            '${teacher.title} ${teacher.name} ${teacher.surname}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 120, right: 120),
                            child: _buildButton(context, 'View Profile',
                                RouteManagerProvider.tdetails),
                          ),
                          const SizedBox(height: 40),
                          _buildButton(context, 'Make Announcements',
                              RouteManagerProvider.teacherMakeAnnouncement),
                          const SizedBox(height: 15),
                          _buildButton(
                            context,
                            'View Announcements',
                            RouteManagerProvider.teacherViewListAnnouncent,
                          ),
                          const SizedBox(height: 15),
                          // Buttons
                          if (teacher.mainClass != null) ...[
                            _buildButton(context, 'Class Roaster',
                                RouteManagerProvider.teacherClassRoaster),
                          ] else if (teacher.mainClass == null) ...[
                            rslButton(context, "Not A Class Teacher", () {})
                          ],
                          const SizedBox(height: 40),

                          const Text(
                            "Subjects",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Column(
                            children: [
                              ...[
                                for (var subject in subjects) ...[
                                  sclButton(
                                    context,
                                    subject,
                                    () {
                                      // Navigator.pushNamed(context, RouteManagerProvider.);
                                    },
                                  )
                                ]
                              ]
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Logout Button
                          GestureDetector(
                            onTap: () {
                              logOut();
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

  Widget _buildButton(BuildContext context, String text, String? routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName!);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: const Color(0xFF0F2E34),
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

  Future<void> getTeacher(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      log("responseCode for get teacher: ${response.statusCode}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data['Result'];

        setState(() {
          teacher = Teacher.fromJson(result);
          // String? tcI = teacher.id.toString();
          // Provider.of<LoginProvider>(context, listen: false).teacheI(tcI);

          // for( var group in teacher.groupNP)
          subjects = teacher.subjects!;

          log("Mapped teacher: Name: ${teacher.name}, Email: ${teacher.emailAddress}, ID: ${teacher.id}");
          isLoading = false;
        });
      } else {
        log("Full response: ${response.toString()}");
        log("There is a problem, statusCode ${response.statusCode}, message ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logOut() async {
    try {
      Response response = await http.postRequest(
          "${http.baseUrl}SignIn/SignOut", teacher.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Logged out"),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      log("Exception while login out: $e");
    }
  }
}
