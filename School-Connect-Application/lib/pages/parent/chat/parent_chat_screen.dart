// Import the Flutter Material library
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/chat/chat.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ParentChatScreen extends StatefulWidget {
  const ParentChatScreen({super.key});

  @override
  State<ParentChatScreen> createState() => _ParentChatScreenState();
}

class _ParentChatScreenState extends State<ParentChatScreen> {
  Parent parent = Parent();
  Teacher teacher = Teacher();
  List<Teacher> teachers = [];
  Chat chat = Chat();
  List<Chat> chats = [];
  late HttpService http;
  bool isLoading = false;
  String reas = 'Enquire';

  @override
  void initState() {
    http = HttpService();
    getParent();
    getTeachers();
    super.initState();
  }

  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        chat = Chat(
            id: 0,
            message: messageController.text,
            parentId: parent.id,
            receiverIdentificate: teacher.staffNr,
            schoolId: teacher.schoolID,
            senderIdentificate: parent.idNo,
            teacherId: teacher.id,
            timeSent: DateTime.now(),
            subject: reas);
        chats.add(chat);
        submitMessage();
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [chooseReason()],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: kTextColor,
        ),
        title: Text(
          "${teacher.title} ${teacher.name} ${teacher.surname}",
          style: TextStyle(color: kTextColor),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: chooseReason()),
                for (var chat in chats) ...{
                  if (chat.senderIdentificate == teacher.staffNr) ...{
                    Align(
                      alignment: teacher.staffNr != null
                          ? Alignment.centerLeft
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        decoration: BoxDecoration(
                          color: teacher.staffNr != null
                              ? Color.fromARGB(255, 62, 121, 133)
                              : Color.fromARGB(255, 10, 13, 14),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: teacher.staffNr != null
                                ? const Radius.circular(12)
                                : Radius.zero,
                            bottomRight: teacher.staffNr != null
                                ? Radius.zero
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          "${chat.message}\n${chat.subject} ${chat.timeSent!.hour}:${chat.timeSent!.minute}",
                          style: TextStyle(
                            color: teacher.staffNr != null
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  } else if (chat.receiverIdentificate == teacher.staffNr) ...{
                    Align(
                      alignment: teacher.staffNr != null
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        decoration: BoxDecoration(
                          color: teacher.staffNr != null
                              ? Color(0xFF0F2E34)
                              : Color.fromARGB(255, 30, 67, 75),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: teacher.staffNr != null
                                ? const Radius.circular(12)
                                : Radius.zero,
                            bottomRight: teacher.staffNr != null
                                ? Radius.zero
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          "${chat.message}\n${chat.subject} ${chat.timeSent!.hour}:${chat.timeSent!.minute}",
                          style: TextStyle(
                            color: teacher.staffNr != null
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  }
                }
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFF0F2E34),
                  ),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getParent() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    try {
      Response response = await http
          .getRequest("${http.baseUrl}Parent/GetParentById?id=$token");
      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        setState(() {
          parent = Parent.fromJson(result);
        });
      }
    } catch (e) {
      log("This is the problem from teacher: $e");
    }
  }

  Future<void> getTeachers() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    String? pt = Provider.of<LoginProvider>(context, listen: false).pt;
    try {
      final response = await http.getRequest(
          "${http.baseUrl}Parent/GetTeachersByParent?parentId=$token");
      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        setState(() {
          teachers =
              List<Teacher>.from(result.map((json) => Teacher.fromJson(json)));
          for (int i = 0; i <= teachers.length - 1; i++) {
            if (teachers.isNotEmpty) {
              if (teachers[i].id.toString() == pt) {
                teacher = teachers[i];
                chats = teacher.chats!;
              }
            }
          }
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> submitMessage() async {
    try {
      Response response = await http.postRequest(
          "${http.baseUrl}Chat/SaveChatMessage", chat //model here
          );
      if (response.data["Success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Message sent"),
            duration: Duration(microseconds: 50),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  Widget chooseReason() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F2E34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            reas,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<int>(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: (value) {
              setState(() {
                switch (value) {
                  case 1:
                    reas = "Enquire";
                    break;
                  case 2:
                    reas = "Complaint";
                    break;
                  case 3:
                    reas = "Report";
                    break;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.question_answer, color: Colors.blue),
                    SizedBox(width: 8),
                    Text("Enquire",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.feedback, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("Complaint",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.report, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Report",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
