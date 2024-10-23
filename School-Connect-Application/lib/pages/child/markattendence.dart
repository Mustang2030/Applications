import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({super.key});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
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
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: const Text(
          "Attendence Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Mark Learner Attendence",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            Table(
              children: const [
                TableRow(children: [
                  Text(""),
                  Text(""),
                  Text(""),
                  Text(""),
                ]),
                TableRow(
                  children: [
                    Text(
                      "Learners",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "          Monday",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "          Tuesday",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Text("Thembile Poti"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Thabiso Soaisa"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Lukhanyo May"),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Lebo Senyane"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(""),
                  ],
                ),
                TableRow(
                  children: [
                    Text("Puleng Senyatso"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(""),
                  ],
                ),
                TableRow(
                  children: [
                    Text("Khaya Mathebula"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    IconSelector(),
                    Text(""),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
