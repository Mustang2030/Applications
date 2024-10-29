import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class PrincipalProfileView extends StatefulWidget {
  const PrincipalProfileView({super.key});

  @override
  State<PrincipalProfileView> createState() => _PrincipalProfileViewState();
}

class _PrincipalProfileViewState extends State<PrincipalProfileView> {
  bool _isEditingCell = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    getUser("Principal/GetPrincipalById?id=");
    super.initState();
  }

  bool isLoading = false;
  Principal principal = Principal();
  School school = School();

  // For Images
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _saveChanges() {
    setState(() {
      _isEditingCell = false;
      _isEditingEmail = false;
      _isEditingPassword = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
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
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
              color: kTextColor,
            )),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildCombinedProfileCard(),
                    const SizedBox(height: 24),
                    if (_isEditingCell || _isEditingEmail || _isEditingPassword)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F2E34),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text("Save Changes"),
                        ),
                      ),
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
            // Image.asset(principal.profileImage!),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${principal.name} ${principal.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("Principal", style: TextStyle(fontSize: 18)),
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
            _buildProfileRow("Title", "${principal.title}"),
            _buildProfileRow("Name", "${principal.name}"),
            _buildProfileRow("Surname", "${principal.surname}"),
            _buildProfileRow("Gender", "${principal.gender}"),
            _buildProfileRow("Staff No", "${principal.staffNr}"),
            _buildProfileRow(
                "Emis No", "${principal.principalSchoolNP?.emisNumber}"),
            StyledFormField(
              controller: phoneController,
              decoration: formS(
                "Phone Number",
                "",
                Icons.phone,
                iconColor: Color(0xFF0F2E34),
              ),
            ),
            StyledFormField(
              controller: emailController,
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
            principal = Principal.fromJson(result);
            emailController.text = principal.emailAddress!;
            phoneController.text = principal.phoneNumber.toString();

            // Set values to controllers after data is fetched

            log("Mapped SystemAdmin: Name: ${principal.name}, Email: ${principal.emailAddress}, School Name: ${principal.principalSchoolNP!.name}");
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

  // Update principal
  Future<void> updateUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      FormData formData = FormData.fromMap({
        'id': principal.id,
        'title': principal.title,
        'profileImage': principal.profileImage,
        'name': principal.name,
        'surname': principal.surname,
        'gender': principal.gender,
        'role': principal.role,
        'staffNr': principal.staffNr,
        'emailAddress': emailController.text,
        'phoneNumber': phoneController.text,
        'schoolID': principal.schoolID,
        'principalSchoolNP': principal.principalSchoolNP,
        'announcementsNP': principal.announcementsNP,
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
          "${http.baseUrl}Principal/UpdatePrincipal", formData);
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
