import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/routes/routes.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        // leading: DrawerButton(),
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
                    rslButton(context, "MARK ATTENDENCE", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.mattendence);
                    }),
                    rslButton(context, "MAKE REPORTS", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.makereport);
                    }),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
                    //   child: rslButton(context, "BACK", () {
                    //     Navigator.pop(context);
                    //   }),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
