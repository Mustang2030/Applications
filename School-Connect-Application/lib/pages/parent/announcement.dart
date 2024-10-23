import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';

class AnnouncementS extends StatefulWidget {
  const AnnouncementS({super.key});

  @override
  State<AnnouncementS> createState() => _AnnouncementSState();
}

class _AnnouncementSState extends State<AnnouncementS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        // actions: const [DrawerButton()],
      ),
      //Parent View List of Announcements
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const Column(
            children: [
              Text(
                "Announcements",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "12\t\t Total",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 390),
                  Icon(Icons.search)
                ],
              ),
              Announ(
                icon: Icons.check_circle,
                from: "GENERAL ANNOUNCEMENTS",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "MATHEMATICS",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "PHYSICAL SCIENCES",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.circle,
                from: "THCSA AL",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "MATHEMATICS",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "LIFE ORIENTATION",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "LIFE SCIENCES",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
              Announ(
                icon: Icons.check_circle,
                from: "GENERAL ANNOUNCEMENTS",
                mess:
                    "Dear parents. Tomorrow is sports day. Can learners please wear...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
