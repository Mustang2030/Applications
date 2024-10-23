import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              const Text(
                "Communicate with a Teacher",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              //Mr John
              const Person(
                name: "Mr John Baker",
                subject: "Geography",
              ),
              const SizedBox(height: 10),
              const Person(
                name: "Ms Selina Bochedi",
                subject: "Life Sciences",
              ),
              const SizedBox(height: 10),
              const Person(
                name: "Mrs Puleng Mokoena",
                subject: "Mathematics",
              ),
              const SizedBox(height: 10),
              const Person(
                name: "Ms Jose Frika",
                subject: "Physical Sciences",
              ),
              const SizedBox(height: 10),
              const Person(
                name: "Mr Frank Gene",
                subject: "English First Additional Language",
              ),
              const SizedBox(height: 10),
              const Person(
                name: "Mr Futo Ren",
                subject: "isiXhosa",
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
                child: rslButton(context, "BACK", () {
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
