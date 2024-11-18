import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/tables.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class SubjClassRoaster extends StatefulWidget {
  const SubjClassRoaster({super.key});

  @override
  State<SubjClassRoaster> createState() => _SubjClassRoasterState();
}

class _SubjClassRoasterState extends State<SubjClassRoaster> {
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getLearners("Learner/GetLearnersByClassID?classId=");
    super.initState();
  }

  List<Learner> learners = [];
  Learner learner = Learner();

  bool isLoading = false;
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
            Text(
              'Class Roaster',
              style: TextStyle(color: kTextColor),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        child: Table(
                          children: [
                            tableMe("ID", "NAME", "SURNAME"),
                            if (learners.isNotEmpty) ...{
                              for (var learner in learners) ...[
                                tableMeInfo(
                                  "${learner.idNo}",
                                  "${learner.name}",
                                  "${learner.surname}",
                                  () {
                                    String learId = learner.idNo.toString();
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .leanr(learId);

                                    Navigator.pushNamed(
                                      context,
                                      RouteManagerProvider.childprot,
                                    );
                                  },
                                ),
                              ],
                            } else if (learners.isEmpty) ...{
                              tableMeInfo(
                                "No Info",
                                "No Info",
                                "No Info",
                                () {},
                              )
                            },
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 350, top: 400),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteManagerProvider.teacherChatList);
                        },
                        backgroundColor:
                            Colors.grey[300], // Chat button background
                        child: const Icon(
                          FontAwesomeIcons.comments,
                          color: Color(0xFF0F2E34), // Chat icon color
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getLearners(String? url) async {
    String? subroast =
        Provider.of<LoginProvider>(context, listen: false).subroast;

    try {
      setState(() {
        isLoading = false;
      });
      Response response = await http.getRequest("${http.baseUrl}$url$subroast");

      if (response.data['Success'] == true) {
        var result = response.data["Result"];
        setState(() {
          learners =
              List<Learner>.from(result.map((json) => Learner.fromJson(json)));
        });
        if (result == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No Learners"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {}
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.response!.data}"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e
              .toString()
              .replaceAll("Exception: ", "")
              .replaceAll("Inner", "")),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
