//From khaya

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scs/consts/constans.dart';

class RolesRegistrationPage extends StatefulWidget {
  const RolesRegistrationPage({super.key});

  @override
  _RolesRegistrationPageState createState() => _RolesRegistrationPageState();
}

class _RolesRegistrationPageState extends State<RolesRegistrationPage> {
  String selectedRole = 'Teacher'; // Default role
  bool showSubjects = false;
  List<String> selectedSubjects = []; // List to store selected subjects

  // Function to toggle the visibility of subjects selection
  void toggleSubjects(String role) {
    setState(() {
      showSubjects = role == 'Teacher';
    });
  }

  void _showSubjectSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Subjects"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ...[
                  'English',
                  'Mathematics',
                  'Social Sciences',
                  'Economics',
                  'Afrikaans',
                  'Life Orientation',
                  'Life Skills',
                ].map((subject) {
                  return CheckboxListTile(
                    title: Text(subject),
                    value: selectedSubjects.contains(subject),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected != null && selected) {
                          selectedSubjects.add(subject);
                        } else {
                          selectedSubjects.remove(subject);
                        }
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: kTextColor,
          ),
        ),
        backgroundColor: const Color(0xFF0F2E34),
        centerTitle: true,
        title: Text(
          'Roles Registration',
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap content with scroll view
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8FF),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.user,
                    size: 100,
                    color: Color(0xFF0F2E34),
                  ),
                  SizedBox(height: 20),
                  _buildInputGroup("Title:", _buildTitleDropdown()),
                  _buildInputGroup(
                      "First Name:", _buildTextInput("Enter First Name")),
                  _buildInputGroup(
                      "Last Name:", _buildTextInput("Enter Last Name")),
                  _buildInputGroup(
                      "Identity Number:", _buildTextInput("Identity Number")),
                  _buildInputGroup(
                      "Date of Birth:", _buildDateInput("Date of Birth")),
                  _buildInputGroup("Gender:", _buildGenderDropdown()),
                  _buildInputGroup(
                      "Cell Number:", _buildTextInput("Cell Number")),
                  _buildInputGroup(
                      "Telephone Number:", _buildTextInput("Telephone Number")),
                  _buildInputGroup("Email Address:",
                      _buildTextInput("Email Address", isEmail: true)),
                  _buildInputGroup("Default Password:",
                      _buildTextInput("Default Password", isPassword: true)),
                  _buildInputGroup("School EMIS Number:",
                      _buildTextInput("School EMIS Number")),
                  _buildInputGroup("Role:", _buildRoleDropdown()),
                  if (showSubjects) _buildSubjectsDropdown(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle registration logic here
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Registered!')));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: Color(0xFF0F2E34),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Text('REGISTER'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputGroup(String label, Widget input) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          input,
        ],
      ),
    );
  }

  Widget _buildTextInput(String placeholder,
      {bool isEmail = false, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateInput(String placeholder) {
    return TextField(
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
      },
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTitleDropdown() {
    return DropdownButton<String>(
      items: ['Mr', 'Mrs', 'Ms', 'Miss'].map((String title) {
        return DropdownMenuItem<String>(
          value: title,
          child: Text(title),
        );
      }).toList(),
      onChanged: (value) {},
      isExpanded: true,
      hint: Text("Select Title"),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButton<String>(
      items: ['Male', 'Female'].map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {},
      isExpanded: true,
      hint: Text("Select Gender"),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButton<String>(
      value: selectedRole,
      items: ['Teacher', 'Parent', 'Principal', 'Guardian'].map((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value!;
          toggleSubjects(value);
        });
      },
      isExpanded: true,
    );
  }

  Widget _buildSubjectsDropdown() {
    return GestureDetector(
      onTap: _showSubjectSelectionDialog,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedSubjects.isEmpty
                  ? "Select Subjects"
                  : selectedSubjects.join(", "),
              style: TextStyle(
                  color: selectedSubjects.isEmpty ? Colors.grey : Colors.black),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
