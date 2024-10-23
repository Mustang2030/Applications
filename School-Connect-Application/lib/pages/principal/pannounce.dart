import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/pickers.dart';

class PAnnouncements extends StatefulWidget {
  const PAnnouncements({super.key});

  @override
  State<PAnnouncements> createState() => _PAnnouncementsState();
}

class _PAnnouncementsState extends State<PAnnouncements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Make Announcements
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const StyledFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Text(
                "Recipients",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const StyledFormField(
                isDropdown: true,
                dropdownItems: [
                  "All Parents",
                  "Grade 8",
                  "Grade 9",
                  "Grade 10",
                  "Grade 11",
                  "Grade 12"
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "MESSAGE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const TextField(
                minLines: 5,
                maxLines: 20,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                from: "Send an mail and an SMS",
                mess: "",
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.check_box,
                from: "Schedule your announcement",
                mess: "",
              ),
              const SizedBox(height: 10),
              CheckB(
                icon: Icons.calendar_month,
                from: "Show On",
                mess: "",
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: DatePickerM(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TimePicker(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
                child: rslButton(context, "SEND", () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("You have successfuly sent your announcement."),
                    ),
                  );
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
