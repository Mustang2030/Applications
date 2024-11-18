import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class ChildProfile extends StatefulWidget {
  const ChildProfile({super.key});

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  late HttpService http;
  bool isLoading = false;
  Parent parent = Parent();
  Learner learner = Learner();
  List<LearnerParent> learnerParent = [];
  School school = School();
  List<String> subjects = [];
  SubGrade clas = SubGrade();

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
          icon: const Icon(Icons.arrow_back),
        ),
        // actions: [DrawerButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.person,
                        size: 75,
                      ),
                      Text(
                        "${learner.name} ${learner.surname}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "GRADE ${learner.classCode}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0F2E34),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Text(
                              "Class Teacher: ${clas.mainTeacher?.title}  ${clas.mainTeacher?.name}  ${clas.mainTeacher?.surname}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              "Subjects: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            for (final sub in subjects) ...[
                              Text(
                                sub,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ]
                            // Text(
                            //     "CLASS TEACHER: KGOPOLO MOOI\nSUBJECTS: ${learner.subjects}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      rslButton(context, "ANNOUNCEMENTS", () {
                        Navigator.pushNamed(context,
                            RouteManagerProvider.parentViewListAnnouncemnt);
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(350, 0, 0, 30),
                  child: FloatingActionButton(
                      backgroundColor: const Color(0xFF0F2E34),
                      child: const Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteManagerProvider.contactlist);
                      }),
                )
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
        var result = response.data["Result"];

        setState(() {
          parent = Parent.fromJson(result);
          learnerParent = parent.children!;

          log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
          isLoading = false;
        });
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
    log("The learners name is ${learner.name}");
    token = learnerParent.first.learner!.id.toString();

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data["Result"];

        setState(() {
          learner = Learner.fromJson(result);

          clas = learner.clas!;

          subjects = clas.subjectsTaught!;
          log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
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
}
