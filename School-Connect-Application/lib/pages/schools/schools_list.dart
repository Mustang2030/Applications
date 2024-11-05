import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/routes/routes.dart';

import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';
import 'package:scs/models/parent/parent.dart';

class SchoolsList extends StatefulWidget {
  const SchoolsList({super.key});

  @override
  State<SchoolsList> createState() => _SchoolsListState();
}

class _SchoolsListState extends State<SchoolsList> {
  late HttpService http;
  bool isLoading = false;
  Parent parent = Parent();
  Learner learner = Learner(parents: []);
  List<LearnerParent> learnerParent = [];
  School school = School();
  List<Learner> learners = [];

  @override
  void initState() {
    http = HttpService();
    getParent("Parent/GetParentById?id=");

    super.initState();
  }

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
            )),

        backgroundColor: const Color(0xFF0F2E34),
        // actions: const [
        //   DrawerButton(),
        // ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    children: [
                      // Actual image of the school will be held here
                      Image.asset(
                        "assets/images/harmonia.jpg",
                        scale: 2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${school.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //list of learners
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : learners.isNotEmpty
                              ? SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: learners.length,
                                    itemBuilder: (context, index) {
                                      final learner = learners[index];
                                      return MaterialButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouteManagerProvider.childpro);
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
                                            "${learner.classCode}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: kTextColor),
                                          ),
                                          //When we have a proper image
                                          // leading: school.logo != null
                                          //     ? Image.network(school.logo!)
                                          //     : const Icon(Icons.school),
                                          title: Text(
                                            "${learner.name} ${learner.surname}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: kTextColor),
                                          ),
                                          subtitle: Text(
                                            "Identity Number : ${learner.idNo}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: kTextColor),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text("Learners are not here."),
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

      if (response.statusCode == 200) {
        var result = response.data['Result'];

        setState(() {
          parent = Parent.fromJson(result);
          learnerParent = parent.children!;
          // Set values to controllers after data is fetched
          // nameController.text = parent.name ?? '';
          // surnameController.text = parent.surname ?? '';
          // emailController.text = parent.emailAddress ?? '';
          // phoneController.text = parent.phoneNumber?.toString() ??
          //     ''; // Handle null numbers

          log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
          isLoading = false;
        });
        // learnerParent =
        //     learnerParent.iterator.current.learner!.id as List<LearnerParent>;
        getLearner("Learner/GetLearnerById?id=");
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

  Future<void> getLearner(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    // for(var kid in parent.children)

    token = learnerParent.first.learner!.id.toString();
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];

        setState(() {
          learner = Learner.fromJson(result);
          learners = [learner].sublist(learners.length);
          // Set values to controllers after data is fetched
          // nameController.text = parent.name ?? '';
          // surnameController.text = parent.surname ?? '';
          // emailController.text = parent.emailAddress ?? '';
          // phoneController.text = parent.phoneNumber?.toString() ??
          //     ''; // Handle null numbers
          if (learner.schoolID != null) {
            getSchools("School/GetSchoolById?schoolId=");
          }

          log("Mapped Leaner: Name: ${learner.name}, ID: ${learner.id}, ID: ${learner.role}");
          isLoading = false;
        });
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

    token = learner.schoolID.toString();

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
            // schools = [school]; // Add the single school to the list
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
}
