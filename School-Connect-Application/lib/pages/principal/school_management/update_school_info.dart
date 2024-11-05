import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class UpdateSchoolInfo extends StatefulWidget {
  const UpdateSchoolInfo({super.key});

  @override
  State<UpdateSchoolInfo> createState() => _UpdateSchoolInfoState();
}

class _UpdateSchoolInfoState extends State<UpdateSchoolInfo> {
  // For Images
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getSchools("School/GetSchoolById?schoolId=");
    super.initState();
  }

  bool isLoading = false;
  School school = School();

  final TextEditingController _cellController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
          'School Profile',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
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
            //Remember to fix the update image
            // Image.network(systemAdmin.profileImageFile as String),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.location_city_sharp,
                  size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${school.name} ${school.type}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text(
                "Principal: ${school.schoolPrincipalNP!.name} ${school.schoolPrincipalNP!.surname}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0F2E34))),
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
            _buildProfileRow("Emis Number", "${school.emisNumber}"),
            _buildProfileRow("School Name", "${school.name}"),
            _buildProfileRow("Type", "${school.type}"),
            // _buildProfileRow("Telephone Number", "${school.telephoneNumber}"),
            // _buildProfileRow("Email Address", "${school.emailAddress}"),
            _buildProfileRow("Date Registered",
                "${school.dateregistered!.day}/${school.dateregistered!.month}/${school.dateregistered!.year}"),
            StyledFormField(
              controller: _cellController,
              decoration: formS(
                "Telephone Number",
                "",
                Icons.phone,
                iconColor: Color(0xFF0F2E34),
              ),
            ),
            StyledFormField(
              controller: _emailController,
              decoration: formS(
                "Email Address",
                "",
                Icons.email,
                iconColor: Color(0xFF0F2E34),
              ),
            ),
            rslButton(context, "Update", () {
              updateSchool("School/UpdateSchool");
            }),
            const SizedBox(height: 16),
            const Text(
              "School Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileRow("Street", "${school.schoolAddress!.street}"),
            _buildProfileRow("Suburb", "${school.schoolAddress!.suburb}"),
            _buildProfileRow("City", "${school.schoolAddress!.city}"),
            _buildProfileRow("Province", "${school.schoolAddress!.province}"),
            _buildProfileRow(
                "Postal Code", "${school.schoolAddress!.postalCode}"),
            const SizedBox(height: 16),
            const Text(
              "System Admin Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileRow("Name", "${school.schoolSysAdminNP!.name}"),
            _buildProfileRow("Surname", "${school.schoolSysAdminNP!.surname}"),
            _buildProfileRow("Gender", "${school.schoolSysAdminNP!.gender}"),
            _buildProfileRow(
                "Staff Number", "${school.schoolSysAdminNP!.staffNr}"),
            _buildProfileRow(
                "Email Address", "${school.schoolSysAdminNP!.emailAddress}"),
            _buildProfileRow(
                "Phone Number", "${school.schoolSysAdminNP!.phoneNumber}"),
          ],
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

  // Get School information
  Future<void> getSchools(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    setState(() {
      isLoading = true;
    });

    try {
      log("Fetching schools");

      // Making the API request
      Response response = await http.getRequest("${http.baseUrl}$url$token");
      log("School response code: ${response.statusCode}");

      // Debugging: Print the entire response to verify its structure
      log("Response data: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var result = response.data;

        // Check if result['Result'] exists and is a Map
        if (result['Success'] == true && result['Result'] != null) {
          var schoolData = result['Result'];

          // Debugging: Print the schoolData to verify the content
          log("Parsed school data: $schoolData");

          setState(() {
            school = School.fromJson(schoolData);
            _cellController.text = school.telephoneNumber.toString();
            _emailController.text = school.emailAddress.toString();

            log("School name: ${school.name}");
          });
          if (school == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("Could not find a school linked to this admin's ID")));
          }
        } else {
          log("Unexpected response format or 'Success' is false");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response format')),
          );
        }
      } else {
        log("Problem, statusCode: ${response.statusCode}, message: ${response.statusMessage}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to load schools: ${response.statusMessage}')),
        );
      }
    } on DioException catch (e) {
      log("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load schools: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Update school information
  Future<void> updateSchool(String url) async {
    try {
      FormData formData = FormData.fromMap({
        'school.id': school.id,
        'school.emisNumber': school.emisNumber,
        'school.logo': school.logo,
        'school.name': school.name,
        'school.dateRegistered': school.dateregistered?.toIso8601String(),
        'school.type': school.type,
        'school.telePhoneNumber': int.tryParse(_cellController.text),
        'school.emailAddress': _emailController.text,
        'school.systemAdminId': school.systemAdminId,

        // School Address
        'school.schoolAddress.schoolID': school.schoolAddress!.schoolID,
        'school.schoolAddress.addressID': school.schoolAddress!.addressID,
        'school.schoolAddress.street': school.schoolAddress!.street,
        'school.schoolAddress.suburb': school.schoolAddress!.suburb,
        'school.schoolAddress.city': school.schoolAddress!.city,
        'school.schoolAddress.province': school.schoolAddress!.province,
        'school.schoolAddress.postalCode': school.schoolAddress!.postalCode,

        'schoolLearnersNP': school.schoolLearnersNP,
        'schoolTeachersNP': school.schoolTeachersNP,
        'schoolAnnouncementNP': school.schoolAnnouncementNP,
        'schoolSysAdminNP': school.schoolSysAdminNP,
        'schoolGroupsNP': school.schoolGroupsNP,
        'schoolPrincipalNP': school.schoolPrincipalNP,
        if (_selectedImage != null) ...{
          'profileImageFile': await MultipartFile.fromFile(
            _selectedImage!.path,
            filename: _selectedImage?.path.split('/').last,
          ),
        },
      });

      log("Request payload: $formData");

      Response response =
          await http.putRequest("${http.baseUrl}School/UpdateSchool", formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("School updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update school"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        log("Failed to school user, statusCode: ${response.statusCode}, message: ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      log("Error occured: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Image picker function
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path); // Get the correct mobile path
      });
    }
  }
}
