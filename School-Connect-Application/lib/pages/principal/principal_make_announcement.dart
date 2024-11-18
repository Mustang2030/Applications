import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/pickers.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/group/group.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart'; // Import this package for formatting dates

class PrincipalMakeAnnouncements extends StatefulWidget {
  const PrincipalMakeAnnouncements({super.key});

  @override
  State<PrincipalMakeAnnouncements> createState() =>
      _PrincipalMakeAnnouncements();
}

class _PrincipalMakeAnnouncements extends State<PrincipalMakeAnnouncements> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getPrincipal("Principal/GetPrincipalById?id=");
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool sendE = false;
  bool sendSms = false;
  bool scheduleAn = false;
  DateTime? dateTime;
  DateTime? datePicked;

  String selectedGroupNames = "";

  String errorMessage = "";
  bool isLoading = false;
  Principal principal = Principal();
  Teacher teacher = Teacher();
  Announcement announcement = Announcement();
  String actorRole = '';
  late List<Group> groups = [];

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
              Text("You can make an announcement here: ${principal.name}"),

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
              MultiSelectDialogField(
                buttonIcon: const Icon(Icons.book),
                buttonText: const Text("Recipients"),
                searchable: true,
                isDismissible: true,
                selectedColor: Colors.black87,
                listType: MultiSelectListType.LIST,
                items: groups
                    .map(
                        (group) => MultiSelectItem(group, "${group.groupName}"))
                    .toList(),
                onConfirm: (values) {
                  setState(() {
                    selectedGroupNames = values
                        .map((group) => (group).groupName ?? "")
                        .join(", ");
                  });
                },
                title: const Text("Select groups"),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
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
                    DateTimePicker(
                      onDateTimeSelected: (dateTim) {
                        setState(() {
                          selectedDateAndTime = dateTim;
                        });
                      },
                    )
                  ]
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: rslButton(context, "SEND", () {
                  setState(() {
                    announcement = Announcement(
                        announcementId: 0,
                        title: titleController.text,
                        recipients: [selectedGroupNames],
                        content: messageController.text,
                        sendEmail: sendE,
                        sendSMS: sendSms,
                        scheduleForLater: scheduleAn,
                        timeToPost: selectedDateAndTime,
                        principalID: principal.id,
                        teacherID: null,
                        schoolID: principal.schoolID,
                        dateCreated: DateTime.now(),
                        viewedRecipients: [principal.staffNr.toString()]);
                  });

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
        announcement,
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Announcement made");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Announcement has been made"),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Failed to make announcement"),
          ),
        );
        Navigator.pop(context);
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Could not make the announcement`   "),
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

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            principal = Principal.fromJson(result);
            groups = principal.principalSchoolNP!.schoolGroupsNP!;
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

  void _timeToPost(DateTime dateTin) {
    setState(() {
      selectedDateAndTime = dateTin;
    });
  }
}
