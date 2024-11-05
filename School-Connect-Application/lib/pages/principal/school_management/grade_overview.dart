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
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class GradeOverview extends StatefulWidget {
  const GradeOverview({super.key});

  @override
  State<GradeOverview> createState() => _GradeOverviewState();
}

class _GradeOverviewState extends State<GradeOverview> {
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
  List<Grade> grades = [];
  List<SubGrade> grade = [];
  SubGrade sGrade = SubGrade();

  @override
  Widget build(BuildContext context) {
    String? tgo = Provider.of<LoginProvider>(context, listen: false).tgo;
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
          "Principal's Grade Overview",
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
                        for (var g in grade) ...[
                          g.mainTeacherId != null
                              ? rslButton(context, g.classDesignate!, () {
                                  setState(() {
                                    tgo = g.classDesignate;
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .principalGradeOverview(tgo!);
                                  });

                                  Navigator.pushNamed(context,
                                      RouteManagerProvider.teachClassProf);
                                })
                              : rslButton(
                                  context,
                                  color: Colors.grey,
                                  g.classDesignate!, () {
                                  setState(() {
                                    tgo = g.classDesignate;
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .principalGradeOverview(tgo!);
                                  });
                                })
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
          await getAllGrades("School/GetAllClassesBySchool?schoolId=$token");
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
                  Text('Failed to load classes: ${response.statusMessage}')),
        );
      }
    } on DioException catch (e) {
      log("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load classes: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getAllGrades(String url) async {
    try {
      Response response = await http.getRequest("${http.baseUrl}$url");
      var data = response.data["Result"];

      if (response.data["Success"] == true) {
        // grades = data.map<Grade>((po) => Grade.fromJson(po)).toList();

        grade = data.map<SubGrade>((po) => SubGrade.fromJson(po)).toList();

        // grade = grades.expand((gradeItem) => gradeItem.classes!).toList();

        // String? maintId =

        // Provider.of<LoginProvider>(context, listen: false).maintId(maintId)

        // log("Parsed SubGrade list: ${grade.map((g) => g.classDesignate).toList()}");
      }
    } on DioException catch (e) {
      log("An error occurred: $e");
    }
  }
}
