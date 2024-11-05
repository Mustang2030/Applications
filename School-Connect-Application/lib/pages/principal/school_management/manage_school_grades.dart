import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class ManageSchoolGrades extends StatefulWidget {
  const ManageSchoolGrades({super.key});

  @override
  State<ManageSchoolGrades> createState() => _ManageSchoolGradesState();
}

class _ManageSchoolGradesState extends State<ManageSchoolGrades> {
  // For Images
  final TextEditingController gradeController = TextEditingController();

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getSchools("School/GetSchoolById?schoolId=");
    super.initState();
  }

  bool isLoading = false;
  bool mainC = false;
  School school = School();
  List<String> classes = [];
  List<Grade> grades = [];
  Grade jGrade = Grade(classes: [SubGrade()]);
  List<SubGrade> grade = [];
  SubGrade sGrade = SubGrade();
  List<Teacher> teachers = [];

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
          'Manage School Grades',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
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
                          controller: gradeController,
                          decoration: formS("",
                              "Enter grades (e.g., 10B, 11B, 12D)", Icons.add,
                              hintTextColor: Colors.grey,
                              iconColor: const Color(0xFF0F2E34)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 275.0),
                          child: rslButton(context, "Add Grade", () {
                            addGrade();
                          }),
                        ),
                        Text(
                          "Existing Grades",
                          style: TextStyle(
                              color: const Color(0xFF0F2E34),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        for (var g in grade) ...[
                          if (g.classDesignate != null)
                            Text(
                              g.classDesignate!,
                              style: TextStyle(
                                  fontSize: 16, color: const Color(0xFF0F2E34)),
                            )
                        ],
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
          await getTeachers(
              "Teacher/GetTeachersBySchool?schoolId=${school.id}");
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

  Future<void> getTeachers(String url) async {
    try {
      Response response = await http.getRequest("${http.baseUrl}$url");
      var data = response.data["Result"];
      if (response.data['Success'] == true) {
        teachers =
            data.map<Teacher>((teach) => Teacher.fromJson(teach)).toList();
      }
    } on DioException catch (e) {
      log("An error occured: $e");
    }
  }

  Future<void> getGrades(String url) async {
    try {
      setState(() {
        isLoading = false;
      });
      Response response = await http.getRequest("${http.baseUrl}$url");
      var data = response.data["Result"];

      if (response.data["Success"] == true) {
        setState(() {
          grades = data.map<Grade>((po) => Grade.fromJson(po)).toList();

          grade = grades.expand((gradeItem) => gradeItem.classes!).toList();
        });

        log("Parsed SubGrade list: ${grade.map((g) => g.classDesignate).toList()}");
      }
    } on DioException catch (e) {
      log("An error occurred: $e");
    }
  }

  Future<void> addGrade() async {
    try {
      setState(() {
        isLoading = true;
      });
      String newGr = gradeController.text;
      classes = [newGr.toString()];

      Response response = await http.putRequest(
        "${http.baseUrl}School/AddClassesToSchool?schoolId=${school.id}",
        classes,
      );

      String? classLis = newGr.toString().toUpperCase();

      if (response.data["Success"] == true) {
        Provider.of<LoginProvider>(context, listen: false)
            .classeslist(classLis);
        grade.add((SubGrade(
            grade: Grade(classes: [
          SubGrade(classDesignate: newGr.toString().trim())
        ]))));
        if (newGr.contains(
            RegExp(r'\b(10|11|12)[A-Z]\b', caseSensitive: true), 0)) {
          Navigator.pushNamed(context, RouteManagerProvider.addSubjects);
        } else {
          Navigator.pop(context);
        }
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text('Class Successfully Added')),
        );

        log("Successfully added a class: ${response.data}");
      } else {
        log("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Error occurred while adding grade: ${e.message}");
      setState(() {
        isLoading = false;
      });
      if (e.response != null) {
        log("Error details: ${e.response?.data}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString().replaceAll("Exception:", "").replaceAll("Inner", ""),
          ),
        ),
      );
    }
  }
}
