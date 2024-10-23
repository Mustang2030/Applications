//From khaya
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/models/school/address.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class SchoolRegistrationForm extends StatefulWidget {
  const SchoolRegistrationForm({super.key});

  @override
  State<SchoolRegistrationForm> createState() => _SchoolRegistrationFormState();
}

class _SchoolRegistrationFormState extends State<SchoolRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idNum = TextEditingController();
  final TextEditingController emisNumber = TextEditingController();
  final TextEditingController schoolName = TextEditingController();
  final TextEditingController dateRegistered = TextEditingController();
  final TextEditingController logo = TextEditingController();
  final TextEditingController systemAdminController = TextEditingController();
  final TextEditingController addressIdController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController suburbController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephone = TextEditingController();

  bool isLoading = false;
  late HttpService http;
  School school = School();
  Address address = Address();
  SystemAdmin systemAdmin = SystemAdmin();
  String errorMessage = "";

  String _selectedSchoolPhase = 'Primary School';
  String _selectedSchoolType = 'Public School';

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getUser('SystemAdmin/GetSystemAdminById?id=');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      backgroundColor: Color(0xFF0F2E34),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.school,
                      size: 70,
                      color: Color(0xFF0F2E34),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextFormField('School Name', 'School Name'),
                  _buildTextFormField('EMIS Number', 'EMIS Number'),
                  _buildDropdownField(
                    'School Phase',
                    ['Primary School', 'High School', 'Combined School'],
                    (value) {
                      setState(() {
                        _selectedSchoolPhase = value!;
                      });
                    },
                    _selectedSchoolPhase,
                  ),
                  _buildDropdownField(
                    'School Type',
                    ['Public School', 'Private School', 'Independent School'],
                    (value) {
                      setState(() {
                        _selectedSchoolType = value!;
                      });
                    },
                    _selectedSchoolType,
                  ),
                  _buildTextFormField('Telephone Number', 'Telephone Number'),
                  _buildTextFormField('Email Address', 'Email Address'),
                  _buildSectionHeader('Physical Address'),
                  _buildTextFormField('Address 1', 'Address 1'),
                  _buildTextFormField('Address 2', 'Address 2'),
                  _buildTextFormField('City', 'City'),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextFormField('Province', 'Province')),
                      SizedBox(width: 20),
                      Expanded(
                          child: _buildTextFormField(
                              'Postal Code', 'Postal Code')),
                    ],
                  ),
                  _buildSectionHeader('Postal Address'),
                  _buildTextFormField('Address 1', 'Address 1'),
                  _buildTextFormField('Address 2', 'Address 2'),
                  _buildTextFormField('District', 'District'),
                  _buildTextFormField('City', 'City'),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextFormField('Province', 'Province')),
                      SizedBox(width: 20),
                      Expanded(
                          child: _buildTextFormField(
                              'Postal Code', 'Postal Code')),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0F2E34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        'REGISTER',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextFormField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hint';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      Function(String?) onChanged, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> getUser(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('current token $token');

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];

        if (response.data["Success"] == true) {
          setState(() {
            systemAdmin = SystemAdmin.fromJson(result);
            // Set values to controllers after data is fetched

            log("Mapped SystemAdmin: Name: ${systemAdmin.name}, Email: ${systemAdmin.emailAddress}, ID: ${systemAdmin.id}");
            isLoading = false;
          });
        }
      } else {
        log("There is a problem, statusCode ${response.statusCode}, message ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
