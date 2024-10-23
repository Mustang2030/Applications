import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';

class AttendanceRecordPage extends StatelessWidget {
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
              color: kTextColor,
              size: 25,
            )),
        title: const Text(
          'Attendance Record',
          style: TextStyle(color: kTextColor),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8), // Correctly defined here
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLearnerInfo(),
              const SizedBox(height: 20),
              _buildAttendanceTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearnerInfo() {
    return Container(
      // Remove color here
      // color: Color(0xFFF0F8F8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8F8), // Move color inside the BoxDecoration
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: Thembile Poti',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Grade: 10B',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Class Teacher: Kgopolo Mooi',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Term: 1',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTable() {
    return Table(
      border: TableBorder.all(
        color: Colors.grey,
        style: BorderStyle.solid,
        width: 1,
      ),
      children: [
        _buildTableHeader(),
        _buildTableRow('Monday', '✔', '', ''),
        _buildTableRow('Tuesday', '✔', '', ''),
        _buildTableRow('Wednesday', '✘', '', ''),
        _buildTableRow('Thursday', '✔', '', ''),
        _buildTableRow('Friday', '✘', '', ''),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      decoration: BoxDecoration(
        color: Color(0xFF0F2E34),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Days',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Week 1',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Week 2',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Week 3',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
      String day, String week1, String week2, String week3) {
    return TableRow(
      children: [
        _buildTableCell(day),
        _buildTableCell(week1),
        _buildTableCell(week2),
        _buildTableCell(week3),
      ],
    );
  }

  TableCell _buildTableCell(String content) {
    Color textColor;
    if (content == '✔') {
      textColor = Colors.green;
    } else if (content == '✘') {
      textColor = Colors.red;
    } else {
      textColor = Colors.black;
    }
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          content,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
