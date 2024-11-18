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
  List<bool> presMarks = [];

  bool isLoading = false;
  DateTime nowdate = DateTime.now();

  Teacher teacher = Teacher();
  List<Learner> learners = [];
  List<Attendence> attendenceRecords = [];
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getAttendenceRecord();
    super.initState();
  }

  void markAtt() {
    setState(() {
      presMarks = List<bool>.filled(learners.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the presMarks list to match the learners list length
    presMarks = List<bool>.filled(learners.length, false);

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
                      "Mark Learner Attendance: ${teacher.mainClass?.classDesignate}",
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
                        for (int i = 0; i < learners.length; i++)
                          tableMeInfoT(
                            learners[i].name,
                            learners[i].surname,
                            presMarks[i],
                            () {
                              markAtt();
                              presMarks[i] = !presMarks[i];

                              log("These are the statuses: ${presMarks.toList()}");
                            },
                          ),
                      },
                    ],
                  ),
                  SizedBox(height: 20),
                  rslButton(context, "Submit", () {
                    // Populate attendance records based on presMarks status
                    attendenceRecords = [
                      for (int i = 0; i < learners.length; i++)
                        Attendence(
                          attendenceId: 0,
                          classId: teacher.mainClass!.id,
                          date: nowdate,
                          learnerId: learners[i].id,
                          schoolId: teacher.schoolID,
                          status: presMarks[i],
                          teacherId: teacher.id,
                        ),
                    ];
                    markAttendance();
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
          learners = teacher.mainClass?.learners ?? [];
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> markAttendance() async {
    try {
      Response response =
          await http.putRequest("Teacher/MarkAttendance", attendenceRecords);

      if (response.data["Success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Submitted attendance"),
            backgroundColor: Colors.green,
          ),
        );
        log("Submitted attendance");
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
