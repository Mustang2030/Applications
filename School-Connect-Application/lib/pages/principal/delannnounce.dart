import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class DelAnnouncementS extends StatefulWidget {
  const DelAnnouncementS({super.key});

  @override
  State<DelAnnouncementS> createState() => _DelAnnouncementSState();
}

class _DelAnnouncementSState extends State<DelAnnouncementS> {
  late HttpService http;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    fetchData();
  }

  Future<void> fetchData() async {
    await getPrincipal("Principal/GetPrincipalById?id=");
    await getTeacher("Teacher/GetTeacherById?id=");
    await getAnnouncements(
        "Announcement/GetAnnouncementByPrincipalId?principalId=");
  }

  bool isLoading = false;
  Principal principal = Principal();
  Teacher teacher = Teacher();
  Announcement announcement = Announcement();
  List<Announcement> announcements = [Announcement()];

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : announcements.isEmpty
                ? const Center(child: Text("No announcements found"))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      final announce = announcements[index];

                      // Extracting the principal or teacher's name from the maps
                      String? senderName = "No one";
                      if (announce.principalAnnouncementNP != null &&
                          announce.principalAnnouncementNP!.name != null) {
                        senderName = announce.principalAnnouncementNP?.name;
                      } else if (announce.teacherAnnouncementNP != null &&
                          announce.teacherAnnouncementNP!.name != null) {
                        senderName = announce.teacherAnnouncementNP!.name;
                      }

                      return ListTile(
                        leading: const Icon(Icons.announcement),
                        title: Text("From: $senderName"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(announce.title ?? 'No title available'),
                            Text(announce.content ?? 'No content available'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Implement delete action
                          },
                        ),
                      );
                    },
                  ));
  }

  Future<void> getAnnouncements(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log("Fetching announcements");

    try {
      setState(() {
        isLoading = true;
      });

      Response response = await http.getRequest("${http.baseUrl}$url$token");
      log("Response status: ${response.statusCode}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Successful response: ${response.data}");

        var result = response.data['Result'];

        if (response.data["Success"] == true) {
          announcement = Announcement.fromJson(result);
          announcements = [result];
          // if (result is List) {
          //   log("Result is a list: $result");

          //   setState(() {
          //     announcements = result
          //         .whereType<Announcement>()
          //         .map<Announcement>((item) =>
          //             Announcement.fromJson(item as Map<String, dynamic>))
          //         .toList();
          //   });

          //   log("Announcements fetched: ${announcements.length}"); // Log the number of announcements
          // } else {
          //   log("Error: 'Result' is not a list");
          //   announcement = Announcement.fromJson(result);
          // }
        } else {
          log("Failed to fetch announcements: ${response.data['Message']}");
        }
      } else {
        log("Error fetching announcements: ${response.statusCode}");
      }
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getPrincipal(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Fetching principal');
    try {
      setState(() {
        isLoading = true;
      });

      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            principal = Principal.fromJson(result);
            log("Mapped Principal: Name: ${principal.name}");
          });
        }
      }
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getTeacher(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Fetching teacher');

    try {
      setState(() {
        isLoading = true;
      });

      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            teacher = Teacher.fromJson(result);
            log("Mapped Teacher: Name: ${teacher.name}");
          });
        }
      }
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
