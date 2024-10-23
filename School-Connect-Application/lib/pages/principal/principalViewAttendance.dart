import 'package:flutter/material.dart';

class ViewAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Learner Attendance\nGrade: 10B',
              style: TextStyle(
                color: Color(0xFF0F2E34),
                fontWeight: FontWeight.bold,
                fontSize: 24,
                //textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: DataTable(
                columns: [
                  const DataColumn(
                    label: Text(
                      'Learner',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Monday',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Tuesday',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Wednesday',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Thursday',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Friday',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                rows: [
                  _createDataRow(
                      'Thembile Poti', true, true, true, true, false),
                  _createDataRow(
                      'Thabiso Soaisa', true, true, true, true, true),
                  _createDataRow(
                      'Lukhanyo May', false, true, false, false, true),
                  _createDataRow('Lebo Senyane', true, true, true, true, true),
                  _createDataRow(
                      'Puleng Senyatso', true, false, true, true, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _createDataRow(String learner, bool monday, bool tuesday,
      bool wednesday, bool thursday, bool friday) {
    return DataRow(
      cells: [
        DataCell(
          GestureDetector(
            onTap: () {
              // Navigate to the learner profile page
              // Navigator.push(context, MaterialPageRoute(builder: (context) => LearnerProfilePage(learner)));
            },
            child: Text(
              learner,
              style: const TextStyle(
                color: Color(0xFF0F2E34),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        DataCell(
          _buildAttendanceIcon(monday),
        ),
        DataCell(
          _buildAttendanceIcon(tuesday),
        ),
        DataCell(
          _buildAttendanceIcon(wednesday),
        ),
        DataCell(
          _buildAttendanceIcon(thursday),
        ),
        DataCell(
          _buildAttendanceIcon(friday),
        ),
      ],
    );
  }

  Widget _buildAttendanceIcon(bool isPresent) {
    return Icon(
      isPresent ? Icons.check : Icons.clear,
      color: isPresent ? Colors.green : Colors.red,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: ViewAttendancePage(),
    ),
  ));
}
