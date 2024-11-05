import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class TeachClassProf extends StatefulWidget {
  const TeachClassProf({super.key});

  @override
  State<TeachClassProf> createState() => _TeachClassProfState();
}

class _TeachClassProfState extends State<TeachClassProf> {
  // For Images
  final TextEditingController gradeController = TextEditingController();

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getSchools();
    super.initState();
  }

  bool isLoading = false;
  bool mainC = false;
  School school = School();
  Teacher teacher = Teacher();
  List<Teacher> teachers = [];
  List<Grade> grades = [];
  List<SubGrade> grade = [];
  List<String> subjects = [];
  Grade oneGrade = Grade();
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
          "Principal's Teacher Overview",
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildCombinedProfileCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image.asset(principal.profileImage!),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${teacher.title} ${teacher.name} ${teacher.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("Main ${teacher.role}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Details section
            Text(
              "Subjects Taught in Class ${sGrade.classDesignate}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),

            const SizedBox(height: 16),
            for (var sub in subjects) ...[
              _buildProfileRow(sub, ""),
            ],
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF0F2E34))),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  // body: isLoading
  //     ? Center(child: const CircularProgressIndicator())
  //     : SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Center(
  //                 child: Text("Class ${sGrade.classDesignate}"),
  //               ),
  //               Text(
  //                   "Class Teacher: ${teacher.title} ${teacher.name} ${teacher.surname}"),
  //               const SizedBox(height: 24),
  //               Text("Subjects Taught:"),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   for (var sub in subjects) ...[Text(sub)]
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //   );
  // }

  // Get School information
  Future<void> getSchools() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    String? tgo = Provider.of<LoginProvider>(context, listen: false).tgo;

    setState(() {
      isLoading = true;
    });

    try {
      log("Fetching schools");

      Response response = await http.getRequest(
          "${http.baseUrl}School/GetClassBySchool?classDesignate=$tgo&schoolId=$token");
      log("School response code: ${response.statusCode}");

      log("Response data: ${response.data["Result"]}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data['Success'] == true) {
          var data = response.data["Result"];

          log("Parsed grade data: $data");

          setState(() {
            sGrade = SubGrade.fromJson(response.data["Result"]);
            subjects = sGrade.subjectsTaught!.cast<String>().toList();
            // subjects = sGrade.(sub) => sub.subjectsTaught!).toList();

            log("School name: ${school.name}");
          });

          await getTeacher("Teacher/GetTeacherById?id=${sGrade.mainTeacherId}");
        } else {
          log("Unexpected response format or 'Success' is false");
        }
      } else {
        log("Problem, statusCode: ${response.statusCode}, message: ${response.statusMessage}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to load schools: ${response.statusMessage}'),
          ),
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

  Future<void> getTeacher(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    try {
      setState(() {
        isLoading = false;
      });
      Response response = await http.getRequest("${http.baseUrl}$url");
      if (response.data['Success'] == true) {
        var result = response.data["Result"];
        setState(() {
          teacher = Teacher.fromJson(result);
          // List<Teacher>.from(result.map((json) => Teacher.fromJson(json)));
        });
      }
    } on DioException catch (e) {
      log("Error bro: ${e.response!.data}");
    }
  }
}
