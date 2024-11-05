import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
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
  // List<Parent> parents = [];
  Learner learner = Learner();
  LearnerParent learnerParent = LearnerParent();
  List<LearnerParent> parents = [];

  School school = School();
  List<School> schools = [School()];

  @override
  void initState() {
    http = HttpService();
    getLearner("Learner/GetLearnerByIdNo?idNo=");
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
        title: const Text(
          'Profile',
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
                    ]),
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
              "${learner.name} ${learner.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("${learner.role}", style: TextStyle(fontSize: 18)),
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
            const Text(
              "Profile Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileRow("Title", "${learner.title}"),
            _buildProfileRow("Name", "${learner.name}"),
            _buildProfileRow("Surname", "${learner.surname}"),
            _buildProfileRow("Gender", "${learner.gender}"),
            _buildProfileRow("ID Number", "${learner.idNo}"),
            _buildProfileRow("Class Code", "${learner.classCode}"),
            const SizedBox(height: 15),
            // Prent info
            for (var rent in parents) ...[
              Text(
                "${rent.parent!.parentType}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F2E34),
                ),
              ),
              _buildProfileRow("Parent Name(s)",
                  "${rent.parent!.name} ${rent.parent!.surname}"),
              _buildProfileRow("Parent Type", "${rent.parent!.name}"),
              _buildProfileRow(
                  "ParentPhone Number", "${rent.parent!.phoneNumber}"),
              _buildProfileRow(
                  "Parent Parent Email", "${rent.parent!.emailAddress}"),
              const SizedBox(height: 10),
            ]

            // _buildProfileRow(
            //     "Class Teacher", "${learner.clas!.mainTeacher!.name}"),
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

  Future<void> getLearner(String url) async {
    String? learId = Provider.of<LoginProvider>(context, listen: false).lerId;

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$learId");

      if (response.data["Success"] == true) {
        var result = response.data["Result"];

        setState(() {
          learner = Learner.fromJson(result);
          parents = learner.parents!;

          // parents = List<LearnerParent>.from(
          //     result.map((json) => LearnerParent(parent: json)));
          // learnerParent = result.map((json) => LearnerParent.fromJson(json));

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
