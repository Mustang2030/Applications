import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              defaultColumnWidth: const FlexColumnWidth(),
              children: const [
                TableRow(
                  children: [
                    Text("Name: Thembile Poti"),
                    Text(""),
                    Text("Grade: 10B"),
                  ],
                ),
                TableRow(children: [
                  Text(""),
                  Text(""),
                  Text(""),
                ]),
                TableRow(
                  children: [
                    Text(
                      "Work Done",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Mark",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.my_library_books_rounded),
                        Text("ASSIGNMENT")
                      ],
                    ),
                    Text("6/27/2024"),
                    Text("25/40"),
                  ],
                ),
                TableRow(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.my_library_books_rounded),
                        Text("ESSAY")
                      ],
                    ),
                    Text("8/27/2024"),
                    Text("100/100"),
                  ],
                ),
                TableRow(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.my_library_books_rounded),
                        Text("TERM TEST")
                      ],
                    ),
                    Text("10/27/2024"),
                    Text("48/50\n"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Report\n",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Table(
              border: const TableBorder(
                  left: BorderSide(),
                  top: BorderSide(),
                  bottom: BorderSide(),
                  right: BorderSide()),
              children: const [
                TableRow(
                  children: [
                    Text(
                      "Subjects",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Percentage",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Level",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Text("English First Additional Language"),
                    Text("    75%"),
                    Text("    6")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Sesotho Home Language"),
                    Text("    86%"),
                    Text("    6")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Computer Applications Technology"),
                    Text("    92%"),
                    Text("    7")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Mathematics"),
                    Text("    73%"),
                    Text("    6")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Life Orientation"),
                    Text("    56%"),
                    Text("    4")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Life Sciences"),
                    Text("    69%"),
                    Text("    5")
                  ],
                ),
                TableRow(
                  children: [
                    Text("Physical Sciences"),
                    Text("    70%"),
                    Text("    6")
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
