import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ChildProfileT extends StatefulWidget {
  const ChildProfileT({super.key});

  @override
  State<ChildProfileT> createState() => _ChildProfileTState();
}

class _ChildProfileTState extends State<ChildProfileT> {
  late HttpService http;
  bool isLoading = false;
  Parent parent = Parent();
  Learner learner = Learner(parents: []);
  LearnerParent learnerParent = LearnerParent();
  School school = School();
  List<School> schools = [School()];

  @override
  void initState() {
    http = HttpService();
    getParent("Parent/GetParentById?id=");
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
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(
              Icons.person,
              size: 100,
            ),
            Text(
              "${learner.title} ${learner.name} ${learner.surname}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              "GRADE ${learner.classCode}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            const Text(
              "CLASS TEACHER: Kgopolo Mooi",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "Identity Number: ${learner.idNo}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "PARENT: ${learnerParent.parent?.name} ${learnerParent.parent?.name}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "PARENT PHONE NO.: ${parent.phoneNumber}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "PARENT EMAIL: ${parent.emailAddress}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            const Text(
              "ADDRESS: 02 Potilolo str\n"
              "                   Rusty\n"
              "                   2424\n"
              "                   North West",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
              child: rslButton(context, "BACK", () {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getParent(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data;

        setState(() {
          parent = Parent.fromJson(result);
          learner = Learner.fromJson(result);
          learnerParent = LearnerParent.fromJson(result);
          // Set values to controllers after data is fetched
          // nameController.text = parent.name ?? '';
          // surnameController.text = parent.surname ?? '';
          // emailController.text = parent.emailAddress ?? '';
          // phoneController.text = parent.phoneNumber?.toString() ??
          //     ''; // Handle null numbers

          log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
          isLoading = false;
        });
        getLearner("Learner/GetLearnerById?id=");
      } else {
        log("There is a problem, statusCode ${response.statusCode}, message ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getLearner(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    var parentIdNo = parent.id;
    token = parentIdNo.toString();
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data;

        setState(() {
          parent = Parent.fromJson(result);
          learner = Learner.fromJson(result);
          learnerParent = LearnerParent.fromJson(result);
          // Set values to controllers after data is fetched
          // nameController.text = parent.name ?? '';
          // surnameController.text = parent.surname ?? '';
          // emailController.text = parent.emailAddress ?? '';
          // phoneController.text = parent.phoneNumber?.toString() ??
          //     ''; // Handle null numbers
          if (learner.schoolID != null) {
            getSchools("School/GetSchoolById?schoolId=");
          }

          log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
          isLoading = false;
        });
      } else {
        log("There is a problem, statusCode ${response.statusCode}, message ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getSchools(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    token = learner.schoolID.toString();

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
            schools = [school]; // Add the single school to the list
            log("School name: ${school.name}");
          });
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
}
