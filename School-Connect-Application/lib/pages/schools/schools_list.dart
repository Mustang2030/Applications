import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/routes/routes.dart';

import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';
import 'package:scs/models/parent/parent.dart';

class SchoolsList extends StatefulWidget {
  const SchoolsList({super.key});

  @override
  State<SchoolsList> createState() => _SchoolsListState();
}

class _SchoolsListState extends State<SchoolsList> {
  late HttpService http;
  bool isLoading = false;
  Parent parent = Parent();
  Learner learner = Learner(parents: []);
  List<LearnerParent> learnerParent = [];
  School school = School();
  List<Learner> learners = [];

  @override
  void initState() {
    http = HttpService();
    getSchoolAndLearner();
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
              color: kTextColor,
            )),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: school.logo != null
                            ? MemoryImage(base64Decode(
                                school.schoolLogoBase64.toString()))
                            : null,
                        child: school.logo == null
                            ? Icon(
                                Icons.church_rounded,
                                size: 50,
                              )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${school.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //list of learners
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : learners.isNotEmpty
                              ? SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: learners.length,
                                    itemBuilder: (context, index) {
                                      final learner = learners[index];
                                      return MaterialButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouteManagerProvider.childpro);
                                        },
                                        child: ListTile(
                                          enableFeedback: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                          tileColor: const Color(0xFF0F2E34),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          leading: Text(
                                            "${learner.classCode}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: kTextColor),
                                          ),
                                          title: Text(
                                            "${learner.name} ${learner.surname}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: kTextColor),
                                          ),
                                          subtitle: Text(
                                            "Identity Number : ${learner.idNo}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: kTextColor),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text("Learners are not here."),
                                ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

// Get the school and learner information
  Future<void> getSchoolAndLearner() async {
    setState(() {
      isLoading = true;
    });
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    String? scho = Provider.of<LoginProvider>(context, listen: false).scho;

    try {
      Response response = await http.getRequest(
          "${http.baseUrl}School/GetSchoolAndLearners?parentId=$token&schoolId=$scho");

      var result = response.data["Result"];
      if (response.data["Success"] == true) {
        setState(() {
          school = School.fromJson(result);
          learners = school.schoolLearnersNP!;
          isLoading = false;

          log("School data has been initialized");
        });
      }
    } catch (e) {
      log("This is a warning");
    }
  }
}
