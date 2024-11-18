import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class ParentsAnnouncementsPage extends StatefulWidget {
  const ParentsAnnouncementsPage({super.key});

  @override
  State<ParentsAnnouncementsPage> createState() =>
      _ParentsAnnouncementsPagePageState();
}

class _ParentsAnnouncementsPagePageState
    extends State<ParentsAnnouncementsPage> {
  late HttpService http;
  List<LearnerParent> learners = [];
  Learner learner = Learner();

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getParent("Parent/GetParentById?id=");
  }

  bool isLoading = false;
  Parent parent = Parent();
  Principal principal = Principal();
  Announcement announcement = Announcement();
  List<Announcement> announcements = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: kTextColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign,
              color: kTextColor,
              size: 34,
            ),
            SizedBox(width: 5),
            Text(
              'Total Announcements: ${announcements.length}',
              style: TextStyle(color: kTextColor),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: Center(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(), // Show loading indicator
              )
            : announcements.isEmpty
                ? const Center(
                    child: Text("No Announcements found"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = announcements[index];
                        return MaterialButton(
                          onPressed: () {
                            // Navigate to detailed page
                            String annkey =
                                announcement.announcementId.toString();
                            Provider.of<LoginProvider>(context, listen: false)
                                .annKey(annkey);
                            Navigator.pushNamed(
                                context, RouteManagerProvider.dannounce);
                          },
                          child: AnnouncementTile(
                            from: "${announcement.title}",
                            message: announcement.content ?? "No content",
                            seen: announcement.viewedRecipients!
                                    .contains(parent.id.toString())
                                ? true
                                : false,
                            pending: principal.id != null ? true : false,
                            delIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ),
                        );
                      },
                    ),
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

      log("The status code is ${response.statusCode} for getting parent and learner data");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data['Success'] == true) {
          var result = response.data['Result'];
          setState(() {
            parent = Parent.fromJson(result);

            learners = parent.children!;

            for (int i = 0; i <= learners.length - 1; i++) {
              learner = learners[i].learner!;
            }

            log("Mapped SystemAdmin: Name: ${parent.name}, Email: ${parent.emailAddress}, ID: ${parent.id}");
            isLoading = false;
          });
        }

        getAnnouncements("Announcement/GetAnnouncementsByTeacherId?id=");
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

  Future<void> getAnnouncements(String url) async {
    // String? token = Provider.of<LoginProvider>(context, listen: false).token;

    log("Fetching announcements");

    try {
      setState(() {
        isLoading = true;
      });

      if (learner.clas != null) {
        String token = learner.clas!.mainTeacherId.toString();
      }
      Response response = await http.getRequest("${http.baseUrl}$url");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data['Result'];

        if (response.data["Success"] == true) {
          // Assuming the result is a list of announcements
          setState(() {
            announcements = List<Announcement>.from(
                result.map((json) => Announcement.fromJson(json)));
          });
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
}
