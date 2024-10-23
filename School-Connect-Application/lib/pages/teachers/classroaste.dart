import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scs/routes/routes.dart';

class ClassRoaster extends StatefulWidget {
  const ClassRoaster({super.key});

  @override
  State<ClassRoaster> createState() => _ClassRoasterState();
}

class _ClassRoasterState extends State<ClassRoaster> {
  final List<Map<String, String>> students = [
    {"number": "1", "name": "Khaya", "surname": "Poti"},
    {"number": "2", "name": "Zola", "surname": "Ngwenya"},
    {"number": "3", "name": "Thandi", "surname": "Nkosi"},
    {"number": "1", "name": "Khaya", "surname": "Poti"},
    {"number": "2", "name": "Zola", "surname": "Ngwenya"},
    {"number": "3", "name": "Thandi", "surname": "Nkosi"},
    {"number": "1", "name": "Khaya", "surname": "Poti"},
    {"number": "2", "name": "Zola", "surname": "Ngwenya"},
    {"number": "3", "name": "Thandi", "surname": "Nkosi"},
    {"number": "1", "name": "Khaya", "surname": "Poti"},
    {"number": "2", "name": "Zola", "surname": "Ngwenya"},
    {"number": "3", "name": "Thandi", "surname": "Nkosi"},
    {"number": "1", "name": "Khaya", "surname": "Poti"},
    {"number": "2", "name": "Zola", "surname": "Ngwenya"},
    {"number": "3", "name": "Thandi", "surname": "Nkosi"},

    // Add more students as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Body background (ghostwhite)
      appBar: AppBar(
        backgroundColor: Color(0xFF0F2E34), // Header background color
        title: const Text(
          "Class Roaster",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20), // Padding from the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8), // Rounded corners (container)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 12), // Shadow styling (box-shadow in CSS)
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0), // Padding for table container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: 520,
                    child: DataTable(
                      columnSpacing: MediaQuery.of(context).size.width /
                          9, // Space between columns
                      headingRowColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          return Color(0xFF0F2E34); // Header background color
                        },
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Number',
                            style: TextStyle(
                              color: Colors.white, // White text for header
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.white, // White text for header
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Surname',
                            style: TextStyle(
                              color: Colors.white, // White text for header
                            ),
                          ),
                        ),
                      ],
                      rows: students.asMap().entries.map((entry) {
                        Map<String, String> student = entry.value;
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                student['number']!,
                                style: const TextStyle(
                                  color: Colors.black, // White text for data
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                student['name']!,
                                style: const TextStyle(
                                  color: Colors.black, // White text for data
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                child: Text(
                                  student['surname']!,
                                  style: const TextStyle(
                                    color: Colors.black, // White text for data
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Evenly space buttons
              children: [
                SizedBox(
                  width: 140, // Set a fixed width for both buttons
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.mattendence);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0F2E34), // Button background
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Button rounding
                      ),
                    ),
                    child: const Text(
                      'MARK ATTENDANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 140, // Set a fixed width for both buttons
                  child: ElevatedButton(
                    onPressed: () {
                      // Make reports action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2E34),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'MAKE REPORTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteManagerProvider.parentChatListPage);
        },
        backgroundColor: Colors.grey[300], // Chat button background
        child: const Icon(
          FontAwesomeIcons.comments,
          color: Color(0xFF0F2E34), // Chat icon color
          size: 20,
        ),
      ),
    );
  }
}
