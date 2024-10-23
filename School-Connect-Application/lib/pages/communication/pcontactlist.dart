import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';

class PContactList extends StatefulWidget {
  const PContactList({super.key});

  @override
  State<PContactList> createState() => _PContactListState();
}

class _PContactListState extends State<PContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: const Text(
          "Teacher Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),*/
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: const Text(
          'Chat List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            SizedBox(height: 10),
            Person(
              name: "Mrs April Poti",
              subject: "Thembile Poti",
            ),
            SizedBox(height: 10),
            Person(
              name: "Mr Lerato Senyane",
              subject: "Lebohang Senyane",
            ),
            SizedBox(height: 10),
            Person(
              name: "Mr Pule Senyatso",
              subject: "Puleng Senyatso",
            ),
            SizedBox(height: 10),
            Person(
              name: "Mrs Zandile Mayekiso",
              subject: "Lukhanyo Mayekiso",
            ),
            SizedBox(height: 10),
            Person(
              name: "Mrs Lwandile Mathebula",
              subject: "Khaya Mathebula",
            ),
            SizedBox(height: 10),
            Person(
              name: "Mrs Thuto Soaisa",
              subject: "Thabiso Soaisa",
            ),
          ],
        ),
      ),
    );
  }
}
