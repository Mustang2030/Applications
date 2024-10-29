import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  //Add a key and form validator on submission
  // final _formKey = GlobalKey<FormState>();

  // For Images
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  TextEditingController profilepicController = TextEditingController();
  TextEditingController staffNrController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adminSelector = TextEditingController();
  late HttpService http;
  Parent parentMod = Parent();
  bool isLoading = false;
  String parent = "";
  bool image = false;
  @override
  void initState() {
    http = HttpService();
    getUser("parent/GetparentById?id=");
    super.initState();
  }

  String profileImage = "";
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
      body: isLoading
          ? const CircularProgressIndicator()
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

                    //this is where it ends for sysAd
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
            // parentMod.profileImage != null
            // ? Image.network(profileImage)
            // :
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "${parentMod.name} ${parentMod.surname}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("${parentMod.role}", style: TextStyle(fontSize: 18)),
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
            _buildProfileRow("Title", "${parentMod.title}"),
            _buildProfileRow("Name", "${parentMod.name}"),
            _buildProfileRow("Surname", "${parentMod.surname}"),
            _buildProfileRow("Gender", "${parentMod.gender}"),
            _buildProfileRow("Identity Number", "${parentMod.idNo}"),
            _buildProfileRow("Parent Type", "${parentMod.parentType}"),

            StyledFormField(
              controller: phoneController,
              decoration: formS("Phone Number",
                  "You can change your phone numeber here", Icons.email,
                  iconColor: Color(0xFF0F2E34)),
            ),
            StyledFormField(
              controller: emailController,
              decoration: formS(
                  "Email", "You can change your email here", Icons.email,
                  iconColor: Color(0xFF0F2E34)),
            ),
            rslButton(context, "Update", () {
              updateUser();
            })
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

    try {
      setState(() {
        isLoading = true;
      });
      log("fetching data...");
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode == 200) {
        var result = response.data['Result'];

        setState(() {
          parentMod = Parent.fromJson(result);
          // Set values to controllers after data is fetched
          nameController.text = parentMod.name ?? '';
          surnameController.text = parentMod.surname ?? '';
          emailController.text = parentMod.emailAddress ?? '';
          phoneController.text =
              parentMod.phoneNumber?.toString() ?? ''; // Handle null numbers
          profileImage = "${http.baseUrl}$url$token//${parentMod.profileImage}";
          log("Mapped parentMod: Name: ${parentMod.name}, Email: ${parentMod.emailAddress}, ID: ${parentMod.id}, profileImage: ${parentMod.profileImage}");
          isLoading = false;
        });
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

  Future<void> updateUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      FormData formData = FormData.fromMap({
        'id': parentMod.id,
        'title': parentMod.title,
        'profileImage': parentMod.profileImage,
        'name': parentMod.name,
        'surname': parentMod.surname,
        'gender': parentMod.gender,
        'role': parentMod.role,
        'idNo': parentMod.idNo,
        'parentType': parentMod.parentType,
        'emailAddress': emailController.text,
        'phoneNumber': phoneController.text,
        if (_selectedImage != null) ...{
          'profileImageFile': await MultipartFile.fromFile(
            _selectedImage!.path,
            filename: _selectedImage?.path.split('/').last,
          ),
        },
      });

      log("Request payload: $formData");

      // Send HTTP PUT request
      Response response =
          await http.putRequest("${http.baseUrl}Parent/Update", formData);
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
