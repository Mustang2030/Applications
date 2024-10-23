import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SchoolAnnouncementsApp extends StatelessWidget {
  const SchoolAnnouncementsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Announcements',
      theme: ThemeData(
        primaryColor: const Color(0xFF0F2E34),
      ),
      home: AnnouncementsPage(), // This is the landing page
    );
  }
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
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
  }

  bool isLoading = false;
  Principal principal = Principal();
  Teacher teacher = Teacher();
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign,
              color: kTextColor,
              size: 34,
            ),
            SizedBox(width: 16),
            Text(
              'Announcements',
              style: TextStyle(color: kTextColor),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
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
                          String key = announcement.announcementId.toString();
                          Provider.of<LoginProvider>(context, listen: false)
                              .passKey(key);
                          Navigator.pushNamed(
                              context, RouteManagerProvider.dannounce);
                        },
                        child: AnnouncementTile(
                          from: "From ${principal.name ?? "Unknown"}",
                          message: announcement.content ?? "No content",
                          pending:
                              false, // You can manage the pending logic here
                        ),
                      );
                    },
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
          await getAnnouncements("Announcement/GetAllAnnBySchool?schoolId=");
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

  Future<void> getAnnouncements(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log("Fetching announcements");

    try {
      setState(() {
        isLoading = true;
      });

      // Use principal.schoolID directly
      Response response =
          await http.getRequest("${http.baseUrl}$url${principal.schoolID}");

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

class SearchSection extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const SearchSection({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total: 12',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F2E34),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Color(0xFF0F2E34)),
              ),
              onChanged: onSearch,
            ),
          ),
        ),
      ],
    );
  }
}

class AnnouncementTile extends StatelessWidget {
  final String from;
  final String message;
  final bool pending; // Add the 'pending' field

  const AnnouncementTile({
    super.key,
    required this.from,
    required this.message,
    this.pending = false, // Make 'pending' optional with a default value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            pending ? Icons.radio_button_unchecked : Icons.check_circle,
            color: pending ? Colors.grey : Colors.green,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  from,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 20,
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
