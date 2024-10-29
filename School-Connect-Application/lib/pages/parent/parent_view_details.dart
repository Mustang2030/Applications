import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ParentDetailAnnounce extends StatefulWidget {
  const ParentDetailAnnounce({super.key});

  @override
  State<ParentDetailAnnounce> createState() => _ParentDetailAnnounceState();
}

class _ParentDetailAnnounceState extends State<ParentDetailAnnounce> {
  late HttpService http;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    http = HttpService();
    getAnnouncement();
  }

  Announcement announcement = Announcement();
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
          ),
        ),
        title: Center(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: kTextColor,
                size: 34,
              ),
              SizedBox(width: 10),
              Text(
                'Announcements',
                style: TextStyle(color: kTextColor),
              ),
            ],
          ),
        ),
        // actions: const [DrawerButton()],
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${announcement.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${announcement.recipients}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Posted on: ${announcement.dateCreated!.day}/${announcement.dateCreated!.month}/${announcement.dateCreated!.year}",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Text(
                          "${announcement.content}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> getAnnouncement() async {
    String? annkey = Provider.of<LoginProvider>(context, listen: false).annkey;
    log("Fetching detailed announcement");
    try {
      setState(() {
        isLoading = true;
      });

      Response response = await http.getRequest(
          "${http.baseUrl}Announcement/GetAnnouncementById?annId=$annkey");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data['Result'];

        if (response.data['Success'] == true) {
          setState(() {
            announcement = Announcement.fromJson(result);
            isLoading = false;
          });
        }
      }
    } on DioException catch (e) {
      log("There is a problem $e");
    }
  }
}
