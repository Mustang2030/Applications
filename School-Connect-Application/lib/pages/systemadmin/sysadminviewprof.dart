import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ProfileViewS extends StatefulWidget {
  const ProfileViewS({super.key});

  @override
  State<ProfileViewS> createState() => _ProfileViewSState();
}

class _ProfileViewSState extends State<ProfileViewS> {
  // For Images
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getUser("SystemAdmin/GetSystemAdminById?id=");
    super.initState();
  }

  bool isLoading = false;
  SystemAdmin systemAdmin = SystemAdmin();
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
          '${systemAdmin.role} Profile',
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
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${systemAdmin.name} ${systemAdmin.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("${systemAdmin.role}", style: TextStyle(fontSize: 18)),
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
            _buildProfileRow("Title", "${systemAdmin.title}"),
            _buildProfileRow("Name", "${systemAdmin.name}"),
            _buildProfileRow("Surname", "${systemAdmin.surname}"),
            _buildProfileRow("Gender", "${systemAdmin.gender}"),

            // _buildProfileRow("Identity Number", "${principal.idNo}"),
            _buildProfileRow("Staff No", "${systemAdmin.staffNr}"),
            systemAdmin.sysAdminSchoolNP?.emisNumber == null
                ? _buildProfileRow("Emis No", "No School Registered")
                : _buildProfileRow(
                    "Emis No", "${systemAdmin.sysAdminSchoolNP?.emisNumber}"),
            StyledFormField(
              controller: _cellController,
              decoration: formS(
                "Phone Number",
                "",
                Icons.phone,
                iconColor: Color(0xFF0F2E34),
              ),
            ),
            StyledFormField(
              controller: _emailController,
              decoration: formS(
                "Email",
                "",
                Icons.email,
                iconColor: Color(0xFF0F2E34),
              ),
            ),
            rslButton(context, "Update", () {
              updateUser();
            }),
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

// Get system admin information
  Future<void> getUser(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;
    log('Role registration page');
    log('current token $token');
    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];
        if (response.data['Success'] == true) {
          setState(() {
            systemAdmin = SystemAdmin.fromJson(result);

            _cellController.text = systemAdmin.phoneNumber.toString();
            _emailController.text = systemAdmin.emailAddress!;
            // Set values to controllers after data is fetche
            log("Mapped SystemAdmin: Name: ${systemAdmin.name}, Email: ${systemAdmin.emailAddress}, School Name: ${systemAdmin.sysAdminSchoolNP!.name}");
            isLoading = false;
          });
        }
      }
    } on Exception catch (e) {
      log("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

// Update system admin
  Future<void> updateUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      FormData formData = FormData.fromMap({
        'id': systemAdmin.id,
        'name': systemAdmin.name,
        'surname': systemAdmin.surname,
        'role': systemAdmin.role,
        'title': systemAdmin.title,
        'gender': systemAdmin.gender,
        'staffNr': systemAdmin.staffNr,
        'emailAddress': _emailController.text,
        'phoneNumber': _cellController.text,
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
          "${http.baseUrl}SystemAdmin/UpdateSystemAdmin", formData);
      log("This is the status code: ${response.statusCode}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
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
