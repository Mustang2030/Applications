import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class Subject extends StatefulWidget {
  const Subject({super.key});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  late HttpService http;
  List<Grade> grades = [];
  Grade grade = Grade();
  List<SubGrade> subs = [];

  @override
  void initState() {
    http = HttpService();
    getClasses();
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
              size: 25,
              color: kTextColor,
            )),
        centerTitle: true,
        title: Text(
          "Teacher's Grade Overview",
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int i = 0; i <= subs.length - 1; i++) ...{
              rslButton(context, "${subs[i].classDesignate}", () {
                String? subj = subs[i].id.toString();
                Provider.of<LoginProvider>(context, listen: false)
                    .subjClaRoa(subj);

                Navigator.pushNamed(
                    context, RouteManagerProvider.subjClassRoaster);
              })
            },
          ],
        ),
      ),
    );
  }

  Future<void> getClasses() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    try {
      Response response = await http.getRequest(
          "${http.baseUrl}Teacher/GetGradesByTeacher?teacherId=$token");

      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        setState(() {
          grades = List<Grade>.from(result.map((json) => Grade.fromJson(json)));
          for (var gra in grades) {
            grade = gra;
            subs = grade.classes!;
          }
        });
        log("Recieved");
      }
    } catch (e) {
      log("This is the error: $e");
    }
  }
}
