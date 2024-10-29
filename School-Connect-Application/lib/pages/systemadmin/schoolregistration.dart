import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/school/address.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class SchoolRegistration extends StatefulWidget {
  const SchoolRegistration({super.key});

  @override
  State<SchoolRegistration> createState() => _SchoolRegistrationState();
}

class _SchoolRegistrationState extends State<SchoolRegistration> {
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
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String selectedSchoolType = "Primary"; // Initialize with a default value
  String selectedProvince = "Gauteng";

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getUser('SystemAdmin/GetSystemAdminById?id=');
  }

  @override
  Widget build(BuildContext context) {
    // String? token = Provider.of<LoginProvider>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Text(
                  "${systemAdmin.name} ${systemAdmin.surname}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F2E34)),
                ),
                const Icon(
                  Icons.vertical_shades_closed_outlined,
                  size: 100,
                  color: Color(0xFF0F2E34),
                ),
                const Text(
                  "Please enter the school's information here",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F2E34)),
                ),
                const SizedBox(height: 20),
                StyledFormField(
                  controller: emisNumber,
                  decoration: formS("EMIS Number",
                      "Please enter the school's EMIS number.", Icons.numbers,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                // Display selected image preview
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                rslButton(context, "School Logo", () {
                  pickImage();
                }),
                StyledFormField(
                  keyboardType: TextInputType.name,
                  controller: schoolName,
                  decoration: formS("School Name",
                      "What's the name of your school?", Icons.school,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Address Fields",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F2E34)),
                ),

                StyledFormField(
                  controller: streetController,
                  decoration: formS("Street", "Enter registration date",
                      Icons.location_on_outlined,
                      iconColor: const Color(0xFF0F2E34)),
                ),

                StyledFormField(
                  controller: cityController,
                  decoration: formS(
                      "City", "Enter registration date", Icons.location_city,
                      iconColor: const Color(0xFF0F2E34)),
                ),

                StyledFormField(
                  controller: suburbController,
                  decoration: formS("Suburb", "Enter registration date",
                      Icons.location_city_sharp,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                StyledFormField(
                  controller: postalCodeController,
                  decoration: formS("Postal Code", "Enter registration date",
                      Icons.location_on_outlined,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                StyledFormField(
                  controller: provinceController,
                  isDropdown: true,
                  selectedItem: selectedProvince,
                  dropdownItems: const [
                    'Gauteng',
                    'Free State',
                    'North West',
                    'Eastern Cape',
                    'Limpopo',
                    'Kwa-Zulu Natal',
                    'Western Cape',
                  ],
                  decoration: formS("Province", "Enter registration date",
                      Icons.location_on_outlined,
                      iconColor: const Color(0xFF0F2E34)),
                  onChanged: (value) {
                    setState(() {
                      selectedProvince = value;
                      address.province =
                          selectedProvince; // Set province in the model
                    });
                  },
                ),
                StyledFormField(
                  controller: telephone,
                  decoration: formS(
                      "Telephone", "Enter school telephone number", Icons.phone,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                StyledFormField(
                  controller: emailController,
                  decoration: formS("Email", "Enter school email", Icons.email,
                      iconColor: const Color(0xFF0F2E34)),
                ),
                // Dropdown for School Type
                StyledFormField(
                  isDropdown: true,
                  selectedItem: selectedSchoolType,
                  dropdownItems: const ["Primary", "High", "Combined"],
                  decoration: formS("School Type", "", Icons.school,
                      iconColor: const Color(0xFF0F2E34)),
                  onChanged: (value) {
                    setState(() {
                      selectedSchoolType = value;
                      school.type =
                          selectedSchoolType; // Set school type in the model
                    });
                  },
                ),

                Text(
                  errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                rslButton(
                  context,
                  isLoading ? "Processing..." : "REGISTER",
                  isLoading
                      ? () {}
                      : () {
                          registerSchool();
                        },
                ),
              ],
            ),
          ),
        ),
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

  bool validateFields() {
    // Add your validation logic here
    if (emisNumber.text.isEmpty || schoolName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return false;
    }
    return true;
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

  // Modified registerSchool function to handle image upload
  Future<void> registerSchool() async {
    if (!validateFields()) return; // Ensure fields are valid

    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering school");

      FormData formData = FormData.fromMap({
        'id': 0,
        'emisNumber': emisNumber.text,
        'logo': "Default Logo",
        'name': schoolName.text,
        'dateRegistered': DateTime.now().toIso8601String(),
        'type': selectedSchoolType,
        'telePhoneNumber': telephone.text,
        'emailAddress': emailController.text,
        'systemAdminId': systemAdmin.id,

        //School Address
        // Flatten the Address fields into the form data
        'schoolAddress.addressID': 0,
        'schoolAddress.street': streetController.text,
        'schoolAddress.suburb': suburbController.text,
        'schoolAddress.city': cityController.text,
        'schoolAddress.postalCode': postalCodeController.text,
        'schoolAddress.province': selectedProvince,
        'schoolAddress.schoolID': 0,

        'schoolLearnersNP': null,
        'schoolTeachersNP': null,
        'schoolAnnouncementNP': null,
        'schoolSysAdminNP': null,
        'schoolGroupsNP': null,
        'schoolPrincipalNP': null,
        'schoolLogoFile': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),
      });

      Response response = await http.postRequest(
          "${http.baseUrl}School/RegisterSchool/", formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully registered your school"),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the school. Please try again."),
          ),
        );
      }

      // Pass FormData directly to the postRequest
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the school"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }
}
