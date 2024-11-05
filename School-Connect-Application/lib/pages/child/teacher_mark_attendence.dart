import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/tables.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({super.key});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  bool isLoading = false;
  DateTime nowdate = DateTime.now();
  bool presMark = false;

  // TeachMkAttendance? attendenceRecord;
  // List<TeachMkAttendance> attendenceRecordsss = [];
  Teacher teacher = Teacher();
  List<Learner> learners = [];
  Learner learner = Learner();
  // SubGrade mainCl = SubGrade();
  Attendence? attendenceRecord;
  List<Attendence> attendenceRecords = [];
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getAttendenceRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> attend = List.filled(learners.length - 1, false);

    void toggleRowState(int rowIndex) {
      attend[rowIndex] = !attend[rowIndex];
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF0F2E34),
        title: Center(
          child: Text(
            "${nowdate.year} Academic Year",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      "Mark Learner Attendence: ${teacher.mainClass?.classDesignate}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F2E34))),
                  SizedBox(height: 20),
                  Table(
                    children: [
                      tableMe("Name", "Surname",
                          "${nowdate.day}/${nowdate.month}/${nowdate.year}"),
                      if (learners.isNotEmpty) ...{
                        for (learner in learners) ...[
                          tableMeInfoT(
                              "${learner.name}", "${learner.surname}", attend,
                              () {
                            toggleRowState(2);
                          })
                        ]
                      },
                    ],
                  ),
                  SizedBox(height: 20),
                  rslButton(context, "Submit", () {
                    for (learner in learners) {
                      setState(() {
                        attendenceRecords = [
                          for (int i = 0; i <= learners.length - 1; i++) ...{
                            attendenceRecord = Attendence(
                              attendenceId: 0,
                              classId: teacher.mainClass!.id,
                              date: nowdate,
                              learnerId: learners[i].id,
                              schoolId: teacher.schoolID,
                              status: presMark,
                              teacherId: teacher.id,
                            )
                          },
                        ];
                      });
                    }
                    markAttendence();
                  })
                ],
              ),
            ),
    );
  }

  Future<void> getAttendenceRecord() async {
    try {
      String? token = Provider.of<LoginProvider>(context, listen: false).token;

      Response response = await http.getRequest(
          "${http.baseUrl}Teacher/GetAttendanceRecordsByTeacher?teacherId=$token");
      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        setState(() {
          teacher = Teacher.fromJson(result);

          learners = teacher.mainClass!.learners!;
          // attendenceRecords = List<Attendence>.from(
          //     result.map((json) => Attendence.fromJson(json)));

          // learners = List<Learner>.from(teacher.mainClass!.learners!
          //     .map((json) => Learner.fromJson(learner.toJson())));
        });
      }
    } catch (e) {}
  }

  Future<void> markAttendence() async {
    try {
      Response response =
          await http.putRequest("Teacher/MarkAttendance", attendenceRecords);

      if (response.data["Success"] == true) {
        log("Submited attendence");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e
              .toString()
              .replaceAll("Inner Exception:", '')
              .replaceAll("Exception:", "")),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
