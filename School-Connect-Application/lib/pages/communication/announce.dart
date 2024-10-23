import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/pickers.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getPrincipal("Principal/GetPrincipalById?id=");
    getTeacher("Teacher/GetTeacherById?id=");
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool sendE = false;
  bool sendSms = false;
  bool scheduleAn = false;
  DateTime? dateTime;
  DateTime? datePicked;

  String selectedRecipients = "All Parents";
  String errorMessage = "";
  bool isLoading = false;
  Principal principal = Principal();
  Teacher teacher = Teacher();
  Announcement announcement = Announcement();
  String actorRole = '';

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    return Scaffold(
      //Make Announcements
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              StyledFormField(
                controller: titleController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Text(
                "Recipients",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              StyledFormField(
                isDropdown: true,
                selectedItem: selectedRecipients,
                dropdownItems: [
                  "All Parents",
                  "Grade 8",
                  "Grade 9",
                  "Grade 10",
                  "Grade 11",
                  "Grade 12"
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (selectedR) {
                  selectedRecipients = selectedR;
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "MESSAGE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextField(
                minLines: 5,
                maxLines: 20,
                controller: messageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                from: "Send an E-mail",
                mess: "",
                onToggle: (esms) {
                  sendE = esms;
                },
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                from: "Send an SMS",
                mess: "",
                onToggle: (esms) {
                  sendSms = esms;
                },
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                from: "Schedule your announcement",
                mess: "",
                onToggle: (esms) {
                  setState(() {
                    scheduleAn = esms;
                  });
                },
              ),
              Column(
                children: [
                  if (scheduleAn == true) ...[
                    const SizedBox(height: 10),
                    CheckB(
                      icon: Icons.check,
                      from: "Show On",
                      mess: "",
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: DatePickerM(initialDate: datePicked),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: TimePicker(initialDateTime: dateTime),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
                child: rslButton(context, "SEND", () {
                  if (actorRole == "Principal") {
                    setState(() {
                      announcement = Announcement(
                        announcementId: 0,
                        title: titleController.text,
                        recipients: [selectedRecipients],
                        content: messageController.text,
                        sendEmail: sendE,
                        sendSMS: sendSms,
                        scheduleForLater: scheduleAn,
                        timeToPost: DateTime.now(),
                        principalID: principal.id,
                        teacherID: null,
                        schoolID: principal.schoolID,
                        dateCreated: DateTime.now(),
                      );
                    });
                  } else if (actorRole == "Teacher") {
                    setState(() {
                      announcement = Announcement(
                        announcementId: 0,
                        title: titleController.text,
                        recipients: [selectedRecipients],
                        content: messageController.text,
                        sendEmail: sendE,
                        sendSMS: sendSms,
                        scheduleForLater: scheduleAn,
                        timeToPost: DateTime.now(),
                        principalID: null,
                        teacherID: teacher.id,
                        schoolID: teacher.schoolID,
                        dateCreated: DateTime.now(),
                      );
                    });
                  }

                  createAnnouncement();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAnnouncement() async {
    try {
      log("Posting announcement");
      Response response = await http.postRequest(
        "${http.baseUrl}Announcement/Create",
        announcement.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Announcement made");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Announcement has been made"),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to make announcement"),
          ),
        );
        Navigator.pop(context);
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the school"),
        ),
      );
    } catch (error) {
      log("$error");
      errorMessage = "$error";
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  Future<void> getPrincipal(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Role registration page');
    log('current token $token');
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            principal = Principal.fromJson(result);
            actorRole = principal.role!;
            // Set values to controllers after data is fetched

            log("Mapped SystemAdmin: Name: ${principal.name}, Email: ${principal.emailAddress}, School Name: ${principal.principalSchoolNP!.name}");
            isLoading = false;
          });
        }
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getTeacher(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Role registration page');
    log('current token $token');

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        setState(() {
          teacher = Teacher.fromJson(response.data);

          // Set values to controllers after data is fetched

          log("Mapped SystemAdmin: Name: ${teacher.name}, Email: ${teacher.emailAddress}, School Name: ${teacher.teacherSchoolNP?.name}");
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
}
