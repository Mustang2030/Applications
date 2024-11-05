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
import 'package:scs/models/teachergrade/teachergrade.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ManageTeacherClassAssignemnt extends StatefulWidget {
  const ManageTeacherClassAssignemnt({super.key});

  @override
  State<ManageTeacherClassAssignemnt> createState() =>
      _ManageTeacherClassAssignemntState();
}

class _ManageTeacherClassAssignemntState
    extends State<ManageTeacherClassAssignemnt> {
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
  Teacher teacher = Teacher();

  List<Teacher> teachers = [];
  List<Grade> grades = [];
  List<SubGrade> grade = [];
  SubGrade subG = SubGrade();
  TeacherGrade tg = TeacherGrade();
  List<TeacherGrade> classes = [];

  Teacher selectedTeach = Teacher();
  SubGrade selectedSubGrade = SubGrade();

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
          'Assign Teachers to Classes',
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
                    const Text(
                      'Teacher:',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    StyledFormField(
                      isDropdown: true,
                      dropdownItems: teachers
                          .map((teach) => teach.emailAddress.toString())
                          .toList(),
                      onChanged: (val) {
                        selectedTeach =
                            teachers.firstWhere((t) => t.emailAddress == val);
                      },
                      decoration: formS("", "", Icons.person),
                    ),
                    const Text(
                      'Grade:',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    StyledFormField(
                      isDropdown: true,
                      dropdownItems: grade
                          .map((gr) => gr.classDesignate.toString())
                          .toList(),
                      onChanged: (val) {
                        selectedSubGrade =
                            grade.firstWhere((gr) => gr.classDesignate == val);
                      },
                      decoration:
                          formS("", "", Icons.format_list_numbered_sharp),
                    ),
                    CheckB(
                      icon: Icons.check_box,
                      icon2: Icons.square,
                      from: "Main Class?",
                      mess: "",
                      onToggle: (clas) {
                        setState(() {
                          mainC = clas;
                        });
                      },
                    ),
                    rslButton(context, "Assign", () {
                      if (mainC == true) {
                        setState(() {
                          selectedSubGrade.mainTeacherId = selectedTeach.id;
                          selectedTeach.mainClass = selectedSubGrade;
                        });
                      } else if (mainC == false) {
                        if (selectedTeach.classes == null ||
                            selectedTeach.classes == []) {
                          setState(() {
                            selectedTeach.classes = classes;
                            selectedTeach.classes?.addAll({
                              TeacherGrade(
                                teacherID: selectedTeach.id,
                                classId: selectedSubGrade.id,
                                staffNr: selectedTeach.staffNr,
                                classDesignate: selectedSubGrade.classDesignate,
                                clas: selectedSubGrade,
                              ),
                            });
                          });
                        }
                      }

                      updateClassAllocation("Teacher/UpdateClassAllocation");
                    })
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
      Response response = await http.getRequest("${http.baseUrl}$url");
      var data = response.data["Result"];

      if (response.data["Success"] == true) {
        grades = data.map<Grade>((po) => Grade.fromJson(po)).toList();

        grade = grades.expand((gradeItem) => gradeItem.classes!).toList();

        // for (subG in grade) {
        //   subG.classDesignate;
        // }

        log("Parsed SubGrade list: ${grade.map((g) => g.classDesignate).toList()}");
      }
    } on DioException catch (e) {
      log("An error occurred: $e");
    }
  }

  Future<void> updateClassAllocation(String url) async {
    try {
      // FormData formData = FormData.fromMap({
      //   'teacher.name': selectedTeach.name,
      //   'teacher.surname': selectedTeach.surname,
      //   'teacher.role': selectedTeach.role,
      //   'teacher.phoneNumber': selectedTeach.phoneNumber,
      //   'teacher.staffNr': selectedTeach.staffNr,
      //   'teacher.gender': selectedTeach.gender,
      //   'teacher.id': selectedTeach.id,
      //   'teacher.title': selectedTeach.title,
      //   'teacher.emailAddress': selectedTeach.emailAddress,
      //   'teacher.subjects': selectedTeach.subjects,
      //   'teacher.mainClass.id': selectedSubGrade.id,
      //   'teacher.mainClass.classDesignate': selectedSubGrade.classDesignate,
      //   'teacher.mainClass.subjectsTaught': selectedSubGrade.subjectsTaught,
      //   'teacher.mainClass.mainTeacherId': selectedTeach.id,
      //   'teacher.mainClass.gradeId': selectedSubGrade.gradeId,
      //   'teacher.mainClass.learners': null,
      //   'teacher.mainClass.mainTeacher': null,
      //   'teacher.mainClass.teachers': null,
      //   'teacher.mainClass.grade': null,
      //   //TeacherGrade
      //   'teacher.classes.teacherID': selectedTeach.id,
      //   'teacher.classes.staffNr': selectedTeach.staffNr,
      //   'teacher.classes.teacher': null,
      //   'teacher.classes.id': selectedSubGrade.id,
      //   'teacher.classes.classDesignate': selectedSubGrade.classDesignate,
      //   'teacher.classes.class': null,
      // NP's
      //   'teacher.schoolId': selectedTeach.schoolID,
      //   'teacher.announcementNP': null,
      //   'teacher.groupNP': null,
      //   'teacher.teacherSchoolNP': null,
      // });
      FormData formData = FormData.fromMap({
        'teacher.name': selectedTeach.name,
        'teacher.surname': selectedTeach.surname,
        'teacher.role': selectedTeach.role,
        'teacher.phoneNumber': selectedTeach.phoneNumber,
        'teacher.staffNr': selectedTeach.staffNr,
        'teacher.gender': selectedTeach.gender,
        'teacher.id': selectedTeach.id,
        'teacher.title': selectedTeach.title,
        'teacher.emailAddress': selectedTeach.emailAddress,
        'teacher.subjects': selectedTeach.subjects,
        // If Main Class is true
        if (mainC == true) ...{
          'teacher.mainClass.id': selectedSubGrade.id,
          'teacher.mainClass.classDesignate': selectedSubGrade.classDesignate,
          'teacher.mainClass.subjectsTaught': selectedSubGrade.subjectsTaught,
          'teacher.mainClass.mainTeacherId': selectedTeach.id,
          'teacher.mainClass.gradeId': selectedSubGrade.gradeId,
          'teacher.mainClass.learners': null,
          'teacher.mainClass.mainTeacher': null,
          'teacher.mainClass.teachers': null,
          'teacher.mainClass.grade': null,
        },

        //TeacherGrade
        if (!mainC) ...{
          'teacher.classes[0].teacherID': selectedTeach.id,
          'teacher.classes[0].staffNr': selectedTeach.staffNr,
          'teacher.classes[0].teacher': null,
          'teacher.classes[0].id': selectedSubGrade.id,
          'teacher.classes[0].classDesignate': selectedSubGrade.classDesignate,
          'teacher.classes[0].class.id': selectedSubGrade.id,
          'teacher.classes[0].class.gradeId': selectedSubGrade.gradeId,
          'teacher.classes[0].class.classDesignate':
              selectedSubGrade.classDesignate,
          'teacher.classes[0].class.mainTeacherId':
              selectedSubGrade.mainTeacherId,
          'teacher.classes[0].class.subjectsTaught[0]':
              selectedSubGrade.subjectsTaught,
        },

        'teacher.schoolId': selectedTeach.schoolID,
        'teacher.announcementNP': null,
        'teacher.groupNP': null,
        'teacher.teacherSchoolNP': null,
      });
      // Send the request
      Response response =
          await http.putRequest("${http.baseUrl}$url", formData);
      if (response.data["Success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text("Class allocation was updated successfully")),
        );
        log("Class allocation was updated successfully");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Failed to allocate a class"),
          ),
        );
      }
    } on DioException catch (e) {
      log("Error updating class allocation: ${e.response!.statusMessage}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString().replaceAll("Exception: ", "")),
        ),
      );
    }
  }
}
