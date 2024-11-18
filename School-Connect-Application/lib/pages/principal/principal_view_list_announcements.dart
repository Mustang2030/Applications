import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class PrincipalListAnnouncementsPage extends StatefulWidget {
  const PrincipalListAnnouncementsPage({super.key});

  @override
  State<PrincipalListAnnouncementsPage> createState() =>
      _PrincipalListAnnouncementsPageState();
}

class _PrincipalListAnnouncementsPageState
    extends State<PrincipalListAnnouncementsPage> {
  late HttpService http;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getPrincipal("Principal/GetPrincipalById?id=");
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
                            from:
                                // The commented one is to be used when NP are set
                                "${announcement.title}",
                            message: announcement.content ?? "No content",
                            seen: announcement.viewedRecipients!
                                    .contains(principal.id.toString())
                                ? true
                                : false,
                            pending:
                                announcement.principalID != null ? true : false,
                            delIcon: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  deleteAnnouncement(
                                      announcement.announcementId);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
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
          await getAnnouncements(
              "Announcement/GetAllAnnBySchool?schoolId=${principal.schoolID}");
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

  Future<void> getAnnouncements(String url) async {
    // String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log("Fetching announcements");

    try {
      setState(() {
        isLoading = true;
      });

      // Use principal.schoolID directly
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

  Future<void> deleteAnnouncement(int? id) async {
    try {
      Response response = await http.deleteRequest(
          "${http.baseUrl}Announcement/Delete?announcementId=$id");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Announcement made");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Announcement has been deleted"),
            backgroundColor: Colors.green,
          ),
        );
        await getAnnouncements(
            "Announcement/GetAllAnnBySchool?schoolId=${principal.schoolID}");
      }
    } on DioException catch (e) {
      log("Put me into your blody arms${e.response!.data}");
    }
  }

  Future<void> editAnnouncement() async {
    try {
      Response response = await http.putRequest(
          "${http.baseUrl}Announcement/Update", announcements);
    } on DioException catch (e) {
      log("Error bro: $e");
    }
  }
}
