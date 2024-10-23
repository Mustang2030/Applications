import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(""),
            Table(
              children: const [
                TableRow(
                  children: [
                    Text("Name: Thembile Poti"),
                    Text("Grade: 10B"),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(children: [Text(""), Text(""), Text(""), Text("")]),
                TableRow(
                  children: [
                    Text(
                      "Days",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Week 1",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Week 2",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Week 3",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("Monday"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Tuesday"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Wednesday"),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Thursday"),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Friday"),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    Text(""),
                    Text("")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
