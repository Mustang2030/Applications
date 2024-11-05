import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/pickers.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart'; // Import this package for formatting dates

class MakeSchoolAnnouncementPage extends StatefulWidget {
  const MakeSchoolAnnouncementPage({super.key});

  @override
  State<MakeSchoolAnnouncementPage> createState() =>
      _MakeSchoolAnnouncementPage();
}

class _MakeSchoolAnnouncementPage extends State<MakeSchoolAnnouncementPage> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await getPrincipal("Principal/GetPrincipalById?id=");
    await getTeacher("Teacher/GetTeacherById?id=");
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedTime = TextEditingController();

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
  DateTime? selectedDateAndTime;

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
          ),
        ),
        title: Text(
          "${principal.principalSchoolNP?.name} ${principal.principalSchoolNP?.type} Announcements",
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (actorRole == "Principal") ...[
                Text("You can make an announcement here: ${principal.name}")
              ],
              const Text(
                "Title:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StyledFormField(
                controller: titleController,
                decoration: formS("", "Enter title", Icons.edit),
              ),
              const SizedBox(height: 20),
              const Text(
                "Recipients:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StyledFormField(
                isDropdown: true,
                selectedItem: selectedRecipients,
                dropdownItems: [
                  if (teacher.teacherSchoolNP!.type == "Primary") ...[
                    "All Parents",
                    "Grade 1",
                    "Grade 2",
                    "Grade 3",
                    "Grade 4",
                    "Grade 5",
                    "Grade 6",
                    "Grade 7",
                  ] else if (teacher.teacherSchoolNP!.type == "High") ...[
                    "All Parents",
                    "Grade 8",
                    "Grade 9",
                    "Grade 10",
                    "Grade 11",
                    "Grade 12"
                  ] else if (teacher.teacherSchoolNP!.type == "Combined") ...[
                    "All Parents",
                    "Grade 1",
                    "Grade 2",
                    "Grade 3",
                    "Grade 4",
                    "Grade 5",
                    "Grade 6",
                    "Grade 7",
                    "Grade 8",
                    "Grade 9",
                    "Grade 10",
                    "Grade 11",
                    "Grade 12"
                  ]
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (selectedR) {
                  selectedRecipients = selectedR;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Message:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 5,
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter message',
                ),
              ),
              const SizedBox(height: 20),
              // Checkbox for "Send an email and SMS"
              CheckB(
                icon: Icons.check_box,
                icon2: Icons.square,
                from: "Send an e-mail",
                mess: "",
                onToggle: (esms) {
                  sendE = esms;
                },
              ),
              // Checkbox for "Schedule your announcement"
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                icon2: Icons.square,
                from: "Send an sms",
                mess: "",
                onToggle: (esms) {
                  sendSms = esms;
                },
              ),
              // Checkbox for "Show On"
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                icon2: Icons.square,
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
                          child: DateTimePicker(
                            onDateTimeSelected: (p0) {
                              selectedDateAndTime = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
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
          actorRole = teacher.role ?? "";

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
