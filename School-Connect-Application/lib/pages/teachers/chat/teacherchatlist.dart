import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class UserChatList extends StatefulWidget {
  const UserChatList({super.key});

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  late HttpService http;
  List<Parent> filterParents = [];
  List<Parent> parents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getParents();
  }

  void _filterList(String search) {
    setState(() {
      filterParents = parents
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
                'Parent List',
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
                    itemCount: filterParents.length,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                        onPressed: () {
                          log("Log parent Id: ${filterParents[index].id}");

                          String tp = filterParents[index].id.toString();
                          Provider.of<LoginProvider>(context, listen: false)
                              .tpChat(tp);

                          Navigator.pushNamed(
                              context, RouteManagerProvider.chatScreen);
                        },
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  filterParents[index].profileImageBase64 !=
                                          null
                                      ? MemoryImage(
                                          scale: 1,
                                          base64Decode(filterParents[index]
                                              .profileImageBase64!),
                                        )
                                      : null,
                              child: filterParents[index].profileImageBase64 ==
                                      null
                                  ? Icon(
                                      Icons.person,
                                      size: 55,
                                    )
                                  : null,
                            ),
                          ),
                          title: Text(
                              "${filterParents[index].title} ${filterParents[index].name} ${filterParents[index].surname}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getParents() async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      final response = await http
          .getRequest("Teacher/GetParentsByTeacherClasses?teacherId=$token");
      if (response.data["Success"] == true) {
        var result = response.data["Result"];
        parents =
            List<Parent>.from(result.map((json) => Parent.fromJson(json)));
        setState(() {
          filterParents = parents;
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
