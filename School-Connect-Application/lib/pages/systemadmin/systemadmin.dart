//To be deleted
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/provider/user.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SystemAdminPage extends StatefulWidget {
  const SystemAdminPage({super.key});

  @override
  State<SystemAdminPage> createState() => _SystemAdminPageState();
}

class _SystemAdminPageState extends State<SystemAdminPage> {
  late HttpService http;
  SystemAdmin systemAdmin = SystemAdmin();
  User? user;
  bool isLoading = false;

  @override
  void initState() {
    http = HttpService();
    getUser("SystemAdmin/GetSystemAdminById?id=");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.person,
                      size: 90,
                    ),
                    Text(
                      "Welcome System Admin ${systemAdmin.name} ${systemAdmin.surname}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 0, 110, 0),
                      child: rslButton(context, "View Profile", () {
                        Navigator.pushNamed(
                          context,
                          RouteManagerProvider.adminprofile,
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    rslButton(context, "REGISTER SCHOOL", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.schoolregistration);
                    }),
                    const SizedBox(height: 20),
                    rslButton(context, "REGISTER ROLES", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.roleregistration);
                    }),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
                      child: rslButton(context, "LOGOUT", () {
                        // Clear user session and return to login page
                        Provider.of<LoginProvider>(context, listen: false)
                            .logout();
                        Navigator.pushReplacementNamed(
                            context, RouteManagerProvider.login);
                      }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getUser(String url) async {
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
}
