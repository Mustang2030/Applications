import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _CantactListState();
}

class _CantactListState extends State<ContactList> {
  late HttpService http;
  List<Teacher> filterTeachers = [];
  List<Teacher> teachers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getTeachers();
  }

  void _filterList(String search) {
    setState(() {
      filterTeachers = teachers
          .where((rent) =>
              (rent.name?.toLowerCase().contains(search.toLowerCase()) ??
                  false) ||
              (rent.surname?.toLowerCase().contains(search.toLowerCase()) ??
                  false))
          .toList();
    });
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
            color: kTextColor,
          ),
        ),
        title: Center(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'List of Teachers',
                style: TextStyle(color: kTextColor),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: _filterList,
                    decoration: const InputDecoration(
                      labelText: 'Search By Using Name or Surname',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterTeachers.length,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                        onPressed: () {
                          log("Log parent Id: ${filterTeachers[index].id}");

                          String pt = filterTeachers[index].id.toString();
                          Provider.of<LoginProvider>(context, listen: false)
                              .ptChat(pt);

                          Navigator.pushNamed(
                              context, RouteManagerProvider.parentChatScreen);
                        },
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  filterTeachers[index].profileImageBase64 !=
                                          null
                                      ? MemoryImage(
                                          scale: 1,
                                          base64Decode(filterTeachers[index]
                                              .profileImageBase64!),
                                        )
                                      : null,
                              child: filterTeachers[index].profileImageBase64 ==
                                      null
                                  ? Icon(
                                      Icons.person,
                                      size: 55,
                                    )
                                  : null,
                            ),
                          ),
                          title: Text(
                              "${filterTeachers[index].title} ${filterTeachers[index].name} ${filterTeachers[index].surname}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getTeachers() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      final response = await http.getRequest(
          "${http.baseUrl}Parent/GetTeachersByParent?parentId=$token");
      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        teachers =
            List<Teacher>.from(result.map((json) => Teacher.fromJson(json)));
        setState(() {
          filterTeachers = teachers;
          isLoading = false;
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
}
