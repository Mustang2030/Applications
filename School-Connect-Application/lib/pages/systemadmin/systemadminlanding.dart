//From khaya
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/provider/user.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SysAdminLandingPage extends StatefulWidget {
  const SysAdminLandingPage({super.key});

  @override
  State<SysAdminLandingPage> createState() => _SysAdminLandingPageState();
}

class _SysAdminLandingPageState extends State<SysAdminLandingPage> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getAdmin("SystemAdmin/GetSystemAdminById?id=");
    super.initState();
  }

  SystemAdmin systemAdmin = SystemAdmin();
  School school = School();
  User? user;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1598978396434-6987130ce46b?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                  15, 46, 52, 0.7), // Transparent background
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 100,
                  color: Color(0xFF0F2E34),
                ),
                const SizedBox(height: 10),
                Text(
                  "${systemAdmin.name} ${systemAdmin.surname}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF8F8FF),
                  ),
                ),
                const SizedBox(height: 20),
                _buildButton(
                  context,
                  "View Profile",
                  () {
                    // Navigate to View Profile page
                    Navigator.pushNamed(
                        context, RouteManagerProvider.sysadminviewprofile);
                  },
                ),
                const SizedBox(height: 20),

                // Make the colors of the buttons to be changeable
                school.id == null
                    ? slButton(context, "Register School", () {
                        Navigator.pushNamed(
                            context, RouteManagerProvider.schoolregistration);
                      })
                    : slButton(context, "${school.name} Registered", () {}),

                const SizedBox(height: 10),
                school.id == null
                    ? slButton(context, "Please Register School", () {})
                    : slButton(context, "Register Roles", () {
                        Navigator.pushNamed(
                            context, RouteManagerProvider.roleregistration);
                      }),

                const SizedBox(height: 20),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to Login page
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: const Text(
        "LOGOUT",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> getAdmin(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('current token $token');

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];

        if (response.data["Success"] == true) {
          setState(() {
            systemAdmin = SystemAdmin.fromJson(result);
            // Set values to controllers after data is fetched

            log("Mapped SystemAdmin: Name: ${systemAdmin.name}, Email: ${systemAdmin.emailAddress}, ID: ${systemAdmin.id}");
            isLoading = false;
          });
          await getSchools("School/GetSchoolByAdminId?adminId=");
        }
      } else {
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
          if (school.id == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
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
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to load schools: $e')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(e
                .toString()
                .replaceAll("Exception: ", "")
                .replaceAll("Inner", ""))),
      );
    }
  }
}
