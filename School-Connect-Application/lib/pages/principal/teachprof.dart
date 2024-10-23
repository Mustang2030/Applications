import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/routes/routes.dart';

class TeacherProf extends StatefulWidget {
  const TeacherProf({super.key});

  @override
  State<TeacherProf> createState() => _TeacherProfState();
}

class _TeacherProfState extends State<TeacherProf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        //     // leading: DrawerButton(),
      ),
      body: Padding(
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
              const Text(
                "Mrs Kgopolo Mooi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: const Column(
                  children: [
                    Text(
                        "STAFF NO: 4115699\nSCHOOL: HARMONIA SECONDARY\nSCHOOL EMIS:44102277\nSCHOOL ADDRESS: 1104 Vill"),
                    Text("\t\t\t\t            Hill"),
                    Text("\t\t\t\t                   Welkom"),
                    Text("\t\t\t\t              2411"),
                  ],
                ),
              ),
              rslButton(context, "VIEW ATTENDENCE", () {
                Navigator.pushNamed(context, RouteManagerProvider.attendencepv);
              }),
              rslButton(context, "VIEW REPORT", () {
                Navigator.pushNamed(context, RouteManagerProvider.pvreport);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
