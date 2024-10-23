import 'package:flutter/material.dart';

class AttendancePV extends StatefulWidget {
  const AttendancePV({super.key});

  @override
  State<AttendancePV> createState() => _AttendancePVState();
}

class _AttendancePVState extends State<AttendancePV> {
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
                    Text("Mrs Mooi leaners"),
                    Text("            Grade: 10B"),
                    Text(""),
                    Text("")
                  ],
                ),
                TableRow(children: [Text(""), Text(""), Text(""), Text("")]),
                TableRow(
                  children: [
                    Text(
                      "Learners",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Monday",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Tuesday",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "           Wednesday",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
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
                      Icons.close,
                      color: Colors.red,
                    ),
                    Text("")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Khaya Mathebula"),
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
                    Text("Puleng Senyatso"),
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
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
