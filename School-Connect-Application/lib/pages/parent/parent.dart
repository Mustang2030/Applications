import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';
import 'package:scs/models/parent/parent.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  late HttpService http;
  bool isLoading = false;
  Parent parent = Parent();
  Learner learner = Learner();
  School school = School();
  List<LearnerParent> learners = [];
  List<LearnerParent> parents = [];

  List<School> schools = [];

  @override
  void initState() {
    http = HttpService();
    getParent("Parent/GetParentById?id=");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String? token = Provider.of<LoginProvider>(context, listen: false).token;

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: kTextColor,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xFF0F2E34),
      // ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_3,
                        size: 90,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Hello ${parent.title} ${parent.name} ${parent.surname} ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(110, 0, 110, 0),
                        child: rslButton(context, "View Profile", () {
                          Navigator.pushNamed(
                              context, RouteManagerProvider.pprofile);
                        }),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "LIST OF SCHOOLS:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: 400,
                      //   child: ListView.builder(
                      //     itemCount: parent.children!.length,
                      //     itemBuilder: (context, index) {
                      //       final child = parent.children![index];
                      //       return MaterialButton(
                      //         onPressed: () {},
                      //         child: ListTile(
                      //           leading: Text("${child.learnerIdNo}"),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : schools.isNotEmpty
                              ? SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: schools.length,
                                    itemBuilder: (context, index) {
                                      final school = schools[index];
                                      return MaterialButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouteManagerProvider.schoolsList);
                                        },
                                        child: ListTile(
                                          enableFeedback: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                          tileColor: const Color(0xFF0F2E34),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          leading: Text(
                                            "${school.type}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: kTextColor),
                                          ),
                                          //When we have a proper image
                                          // leading: school.logo != null
                                          //     ? Image.network(school.logo!)
                                          //     : const Icon(Icons.school),
                                          title: Text(
                                            "${school.name}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: kTextColor),
                                          ),
                                          subtitle: Text(
                                            "Emis Number : ${school.emisNumber}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: kTextColor),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Text("No schools found"),
                                ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(110, 0, 110, 0),
                        child: rslButton(context, "LOG OUT", () {
                          logOut();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> getParent(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      log("The status code is ${response.statusCode} for getting parent and learner data");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data['Success'] == true) {
          var result = response.data['Result'];
          setState(() {
            parent = Parent.fromJson(result);
            //Modifications for today
            // learners = List<LearnerParent>.from(
            //     result.map((json) => LearnerParent.fromJson(json)));
            learner = Learner.fromJson(result);
            // parents = List<LearnerParent>.from(
            //     result.map((json) => LearnerParent.fromJson(json)));

            log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
            isLoading = false;
          });
        }
        getSchools("School/GetSchoolById?schoolId=");

        // getLearner("Learner/GetLearnerById?id=");
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

    // token = learner.schoolID.toString();
    token = parent.children!.first.learner!.schoolID.toString();
    // token = learner.schoolID.toString();

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
            schools = [school]; // Add the single school to the list
            log("School name: ${school.name}");
          });
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

  Future<void> logOut() async {
    try {
      Response response = await http.postRequest(
          "${http.baseUrl}SignIn/SignOut", parent.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
