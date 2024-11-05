import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/validators.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key});

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  //For images
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  bool _isEditingCell = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;
  bool _isPasswordVisible = false;
  //Add a key and form validator on submission
  final _formKey = GlobalKey<FormState>();

  TextEditingController profilepicController = TextEditingController();
  TextEditingController staffNrController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adminSelector = TextEditingController();
  late HttpService http;
  Teacher teacher = Teacher();
  bool isLoading = false;
  bool image = false;

  @override
  void initState() {
    http = HttpService();
    getTeacher("Teacher/GetTeacherById?id=");
    super.initState();
  }

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
              size: 25,
              color: kTextColor,
            )),
        centerTitle: true,
        title: Text(
          '${teacher.role} Profile',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildCombinedProfileCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${teacher.name} ${teacher.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("${teacher.role}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Details section
              const Text(
                "Profile Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F2E34),
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileRow("Title", "${teacher.title}"),
              _buildProfileRow("Name", "${teacher.name}"),
              _buildProfileRow("Surname", "${teacher.surname}"),
              _buildProfileRow("Gender", "${teacher.gender}"),
              _buildProfileRow("Staff No", "${teacher.staffNr}"),
              _buildProfileRow(
                  "Emis No", "${teacher.teacherSchoolNP?.emisNumber}"),
              StyledFormField(
                controller: phoneController,
                validator: validateCap,
                decoration: formS(
                  "Phone Number",
                  "",
                  Icons.phone,
                  iconColor: Color(0xFF0F2E34),
                ),
              ),
              StyledFormField(
                controller: emailController,
                validator: validateCap,
                decoration: formS(
                  "Email",
                  "",
                  Icons.email,
                  iconColor: Color(0xFF0F2E34),
                ),
              ),
              rslButton(context, "Update", () {
                if (_formKey.currentState!.validate()) {
                  updateUser();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF0F2E34))),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Future<void> getTeacher(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      log("responseCode for get teacher: ${response.statusCode}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data['Result'];

        setState(() {
          teacher = Teacher.fromJson(result);
          phoneController.text = teacher.phoneNumber.toString();
          emailController.text = teacher.emailAddress.toString();

          log("Mapped teacher: Name: ${teacher.name}, Email: ${teacher.emailAddress}, ID: ${teacher.id}");
          isLoading = false;
        });
      } else {
        log("Full response: ${response.toString()}");
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

  Future<void> updateUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        FormData formData = FormData.fromMap({
          'id': teacher.id,
          'name': teacher.name,
          'surname': teacher.surname,
          'role': teacher.role,
          'title': teacher.title,
          'gender': teacher.gender,
          'staffNr': teacher.staffNr,
          'emailAddress': emailController.text,
          'phoneNumber': phoneController.text,
          'subjects': teacher.subjects,
          if (_selectedImage != null) ...{
            'profileImageFile': await MultipartFile.fromFile(
              _selectedImage!.path,
              filename: _selectedImage?.path.split('/').last,
            ),
          },
        });

        log("Request payload: $formData");

        // Send HTTP PUT request
        Response response = await http.putRequest(
            "${http.baseUrl}Teacher/UpdateTeacher", formData);

        if (response.statusCode == 200) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Profile updated successfully"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to update profile"),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          log("Failed to update user, statusCode: ${response.statusCode}, message: ${response.statusMessage}");
          setState(() {
            isLoading = false;
          });
        }
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log("An unexpected error occurred: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
