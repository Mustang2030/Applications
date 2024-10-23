import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/provider/login_provider.dart';
// import 'package:scs/provider/user.dart';
import 'package:scs/services/http_service.dart';

class AdminDetails extends StatefulWidget {
  const AdminDetails({super.key});

  @override
  State<AdminDetails> createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
  //Add a key and form validator on submission
  final _formKey = GlobalKey<FormState>();

  TextEditingController profilepicController = TextEditingController();
  TextEditingController staffNrController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late HttpService http;
  SystemAdmin systemAdmin = SystemAdmin();
  // User user = User();
  bool isLoading = false;
  bool image = false;

  @override
  void initState() {
    http = HttpService();
    getUser("SystemAdmin/GetSystemAdminById?id=");
    // fetchUserData("SystemAdmin/GetSystemAdminById?id=");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: MaterialButton(
                                    color: Colors.grey,
                                    shape: const CircleBorder(),
                                    onPressed: () {},
                                    child: image
                                        ? Image.asset(
                                            "${systemAdmin.profileImage}")
                                        : const Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 100,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "Hello ${systemAdmin.name ?? 'N/A'} ${systemAdmin.surname ?? 'N/A'}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              StyledFormField(
                                readonly: true,
                                controller: staffNrController,
                                decoration: formS("Staff Number",
                                    "Not able to edit", Icons.numbers),
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              StyledFormField(
                                controller: nameController,
                                decoration: formS("First Name",
                                    "Write new name here", Icons.person),
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              StyledFormField(
                                controller: surnameController,
                                decoration: formS("Last Name",
                                    "Write new Last Name here", Icons.person),
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              StyledFormField(
                                controller: emailController,
                                decoration: formS(
                                    "Email",
                                    "Write new email address here",
                                    Icons.email),
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              StyledFormField(
                                controller: phoneController,
                                decoration: formS("Phone Number",
                                    "Write new phone number here", Icons.email),
                              ),
                              const SizedBox(height: 20),
                              rslButton(
                                context,
                                "Update",
                                () {
                                  setState(() {
                                    log("Updating information");
                                    systemAdmin.name = nameController.text;
                                    systemAdmin.surname =
                                        surnameController.text;
                                    systemAdmin.emailAddress =
                                        emailController.text;
                                    systemAdmin.phoneNumber =
                                        int.tryParse(phoneController.text);
                                    log("Current info ${systemAdmin.name}, ${systemAdmin.surname}, ${systemAdmin.emailAddress}");
                                    updateUser();
                                  });
                                },
                              )
                            ],
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

        if (response.data["Success"] == true) {
          setState(() {
            systemAdmin = SystemAdmin.fromJson(result);
            // Set values to controllers after data is fetched
            staffNrController.text = systemAdmin.staffNr?.toString() ?? '';
            nameController.text = systemAdmin.name ?? '';
            surnameController.text = systemAdmin.surname ?? '';
            emailController.text = systemAdmin.emailAddress ?? '';
            phoneController.text = systemAdmin.phoneNumber?.toString() ??
                ''; // Handle null numbers

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

  Future<void> updateUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        log("Request payload: ${systemAdmin.toJson()}");

        // Send HTTP PUT request
        Response response = await http.putRequest(
            "${http.baseUrl}SystemAdmin/UpdateSystemAdmin",
            systemAdmin.toJson());
        log("This is the status code: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! <= 299) {
          Map<String, dynamic> result = response.data;
          setState(() {
            systemAdmin = SystemAdmin.fromJson(result);
            log("Mapped SystemAdmin: Name: ${systemAdmin.name}, Email: ${systemAdmin.emailAddress}, ID: ${systemAdmin.id}");
            isLoading = false;
          });
        } else if (response.statusCode == 400) {
          log("Error 400: ${response.data}");
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

  // Future<void> fetchUserData(String url) async {
  //   try {
  //     // Get the token from the LoginProvider
  //     String? token = Provider.of<LoginProvider>(context, listen: false).token;

  //     log("Token after logging in: $token");

  //     if (token != null) {
  //       // Add the token to the request headers
  //       Response response = await http.getRequest(
  //         "${http.baseUrl}$url$token", // Constructed URL
  //       );

  //       if (response.statusCode == 200) {
  //         var result = response.data;

  //         // Ensure 'Success' exists and is a bool
  //         if (response.data['Success'] == true) {
  //           setState(() {
  //             systemAdmin = SystemAdmin.fromJson(result);

  //             // Set values to controllers after data is fetched
  //             staffNrController.text = systemAdmin.staffNr?.toString() ?? '';
  //             nameController.text = systemAdmin.name ?? '';
  //             surnameController.text = systemAdmin.surname ?? '';
  //             emailController.text = systemAdmin.emailAddress ?? '';
  //             phoneController.text = systemAdmin.phoneNumber?.toString() ?? '';

  //             log("Mapped SystemAdmin: Name: ${systemAdmin.name}, Email: ${systemAdmin.emailAddress}, ID: ${systemAdmin.id}");
  //             isLoading = false;
  //           });
  //         } else {
  //           log("Failed to fetch user data: ${response.data['message'] ?? 'Unknown error'}");
  //         }
  //       } else {
  //         log("Failed to fetch user data. Status Code: ${response.statusCode}, Message: ${response.data['message'] ?? 'No message'}");
  //       }
  //     } else {
  //       log("No token found, user might not be logged in.");
  //     }
  //   } catch (error) {
  //     log("Error fetching user data: $error");
  //   }
  // }
}
