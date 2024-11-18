import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SubjectT extends StatefulWidget {
  const SubjectT({super.key});

  @override
  State<SubjectT> createState() => _SubjectTState();
}

class _SubjectTState extends State<SubjectT> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getTeacher();
    super.initState();
  }

  Teacher teacher = Teacher();
  Parent parent = Parent();
  List<Grade> grades = [];
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "GEOGRAPHY",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "CLASSES TAUGHT",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 10",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.subj);
                            },
                            child: const Text(
                              "10B",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.subj);
                            },
                            child: const Text(
                              "10C",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 12",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.subj);
                            },
                            child: const Text(
                              "12A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.subj);
                            },
                            child: const Text(
                              "12B",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTeacher() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      Response response =
          await http.getRequest("Teacher/GetGradesByTeacher?teacherId=$token");

      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        setState(() {
          grades = List<Grade>.from(result.map((json) => Grade.fromJson(json)));
        });
      }
    } catch (e) {
      log("Error here: $e");
    }
  }
}
