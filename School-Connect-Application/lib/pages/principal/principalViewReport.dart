
import 'package:flutter/material.dart';

class LearnerReports extends StatelessWidget {
  const LearnerReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Learner Reports\nGrade: 10B',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F2E34),
                  //textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Learner')),
                  DataColumn(label: Text('Work Done')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Mark')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Thembile Poti')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.book, color: Color(0xFF0F2E34)),
                        const Text('ESSAY'),
                      ],
                    )),
                    DataCell(Text('8/27/2024')),
                    DataCell(Text('47/100')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Thabiso Soaisa')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.book, color: Color(0xFF0F2E34)),
                        const Text('ESSAY'),
                      ],
                    )),
                    DataCell(Text('8/27/2024')),
                    DataCell(Text('100/100')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Lukhanyo May')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.book, color: Color(0xFF0F2E34)),
                        const Text('ESSAY'),
                      ],
                    )),
                    DataCell(Text('8/27/2024')),
                    DataCell(Text('48/100')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
