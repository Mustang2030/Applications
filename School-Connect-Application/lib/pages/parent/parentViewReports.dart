import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';

class ProgressReportScreen extends StatelessWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Prevent automatic leading back button
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            )),
        title: const Text(
          "Progress Report",
          style: TextStyle(color: kTextColor),
        ),
        backgroundColor: const Color(0xFF0F2E34),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Information Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Table(
                  border: TableBorder.all(),
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Name: Thembile Poti',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Term: 1',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Grade: 10B',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              // Work Done Section
              const Text(
                'Work Done',
                style: TextStyle(fontSize: 22, color: Color(0xFF0F2E34)),
              ),
              Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Work Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Mark',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  // Work Rows
                  buildWorkRow(Icons.book, 'Assignment', '25/01/2024', '25/40'),
                  buildWorkRow(Icons.book, 'Essay', '06/02/2024', '100/100'),
                  buildWorkRow(Icons.book, 'Term Test', '31/03/2024', '48/50'),
                ],
              ),

              // Report Card Section
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'Report Card',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F2E34)),
                ),
              ),
              Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Subjects',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Percentage',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Level',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  // Report Card Rows
                  buildReportCardRow(
                      'English First Additional Language', '75%', '6'),
                  buildReportCardRow('Sesotho Home Language', '86%', '6'),
                  buildReportCardRow(
                      'Computer Applications Technology', '92%', '7'),
                  buildReportCardRow('Mathematics', '73%', '6'),
                  buildReportCardRow('Life Orientation', '56%', '4'),
                  buildReportCardRow('Life Sciences', '69%', '5'),
                  buildReportCardRow('Physical Sciences', '70%', '6'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildWorkRow(
      IconData icon, String workType, String date, String mark) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 5),
            Text(workType),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(date),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(mark),
      ),
    ]);
  }

  TableRow buildReportCardRow(String subject, String percentage, String level) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(subject),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(percentage),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(level),
      ),
    ]);
  }
}
