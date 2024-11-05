import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class AddSubjects extends StatefulWidget {
  const AddSubjects({super.key});

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {
  // For Images
  final TextEditingController sub1 = TextEditingController();
  final TextEditingController sub2 = TextEditingController();
  final TextEditingController sub3 = TextEditingController();
  final TextEditingController sub4 = TextEditingController();
  final TextEditingController sub5 = TextEditingController();
  final TextEditingController sub6 = TextEditingController();

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getSchools("School/GetSchoolById?schoolId=");
    super.initState();
  }

  List<String> subjects = [];
  bool isLoading = false;
  bool mainC = false;
  School school = School();
  List<Grade> grades = [];
  List<SubGrade> grade = [];
  SubGrade sGrade = SubGrade();

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
              size: 25,
              color: kTextColor,
            )),
        centerTitle: true,
        title: Text(
          'Add Subjects',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: Color(0xFF0F2E34),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledFormField(
                          controller: sub1,
                          decoration: formS(
                              "Subject 1", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        StyledFormField(
                          controller: sub2,
                          decoration: formS(
                              "Subject 2", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        StyledFormField(
                          controller: sub3,
                          decoration: formS(
                              "Subject 3", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        StyledFormField(
                          controller: sub4,
                          decoration: formS(
                              "Subject 4", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        StyledFormField(
                          controller: sub5,
                          decoration: formS(
                              "Subject 5", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        StyledFormField(
                          controller: sub6,
                          decoration: formS(
                              "Subject 6", "Enter Subject here", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 120.0, left: 120),
                          child: rslButton(context, "Add Subjects", () {
                            setState(() {
                              subjects = [
                                sub1.text,
                                sub2.text,
                                sub3.text,
                                sub4.text,
                                sub5.text,
                                sub6.text
                              ];
                            });
                            addSubjects();
                          }),
                        ),
                        // Text(
                        //   "Existing Grades",
                        //   style: TextStyle(
                        //       color: const Color(0xFF0F2E34),
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // for (var g in grade) ...[
                        //   Text(
                        //     g.classDesignate!,
                        //     style: TextStyle(
                        //         fontSize: 16, color: const Color(0xFF0F2E34)),
                        //   )
                        // ],
                      ],
                    ),
                  ],
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

      Response response = await http.getRequest("${http.baseUrl}$url$token");
      log("School response code: ${response.statusCode}");

      log("Response data: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data;

        if (result['Success'] == true) {
          var schoolData = result['Result'];

          log("Parsed school data: $schoolData");

          setState(() {
            school = School.fromJson(schoolData);

            log("School name: ${school.name}");
          });

          await getGrades("School/GetSchoolGrades?schoolId=${school.id}");
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

  Future<void> getGrades(String url) async {
    try {
      Response response = await http.getRequest("${http.baseUrl}$url");
      var data = response.data["Result"];

      if (response.data["Success"] == true) {
        grades = data.map<Grade>((po) => Grade.fromJson(po)).toList();

        grade = grades.expand((gradeItem) => gradeItem.classes!).toList();

        log("Parsed SubGrade list: ${grade.map((g) => g.classDesignate).toList()}");
      }
    } on DioException catch (e) {
      log("An error occurred: $e");
    }
  }

  Future<void> addSubjects() async {
    try {
      String? classLis =
          Provider.of<LoginProvider>(context, listen: false).classes;
      Response response = await http.putRequest(
          "${http.baseUrl}School/AddSubjectsToSchool?schoolId=${school.id}&newClasses=$classLis",
          subjects);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data["Success"] == true) {
          grade.add((SubGrade(
              grade: Grade(
                  classes: [SubGrade(subjectsTaught: subjects.toList())]))));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.green,
                content: Text("Subjects were added successfully to $classLis")),
          );
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        }

        log("Added a class successfully:${response.data}");
      }
    } on DioException catch (e) {
      log("Error bro: $e");
    }
  }
}
