//To be deleted
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  bool isLoading = false;
  late HttpService http;
  Principal principal = Principal();
  School school = School();
  @override
  void initState() {
    http = HttpService();
    getUser("Principal/GetPrincipalById?id=");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Principal Login...")
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.person_2,
                      size: 90,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Principal ${principal.name} ${principal.surname}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              principal.principalSchoolNP != null
                                  ? "SCHOOL INFORMATION\n\n"
                                      "STAFF NO: ${principal.staffNr ?? ''}\n"
                                      "SCHOOL NAME: ${principal.principalSchoolNP?.name ?? ''}\n"
                                      "SCHOOL EMIS: ${principal.principalSchoolNP?.emisNumber ?? ''}\n"
                                      "REGISTRATION: ${principal.principalSchoolNP?.dateregistered ?? ''}"
                                  : "No School Information Available",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    rslButton(context, "MAKE ANNOUNCEMENTS", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.announce);
                    }),
                    rslButton(context, "VIEW ANNOUNCEMENTS", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.delannounceS);
                    }),
                    rslButton(context, "GRADES", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.gradespv);
                    }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(140, 0, 140, 0),
                      child: rslButton(context, "LOGOUT", () {
                        Navigator.pop(context);
                      }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getUser(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Role registration page');
    log('current token $token');
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            principal = Principal.fromJson(result);

            // Set values to controllers after data is fetched

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
}
