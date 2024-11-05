import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/validators.dart';
import 'package:scs/models/loginmodel/loginmodel.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/provider/user.dart';
import 'package:scs/routes/routes.dart';
import 'package:scs/services/http_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User user = User();

  String errorMessage = "";
  LoginModel login = LoginModel(
      emailAddress: "", password: "", newPassword: "", confirmPassword: "");
  late HttpService http;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    http = HttpService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 34, 41, 1),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 85,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to School Connect',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: emailAddressController,
                      validator: validateCap,
                      textStyle: const TextStyle(color: Colors.white),
                      decoration: formS(
                        "Email",
                        'Write email here',
                        Icons.email,
                        borderColor: Colors.white,
                        iconColor: Colors.white,
                        labelTextColor: Colors.white,
                        hintTextColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: passwordController,
                      validator: validateCap,
                      textStyle: const TextStyle(color: Colors.white),
                      isPassword: true,
                      decoration: formS(
                          "Password", 'Write Email Here', Icons.password_sharp,
                          borderColor: Colors.white,
                          iconColor: Colors.white,
                          labelTextColor: Colors.white,
                          hintTextColor: Colors.white),
                    ),
                    Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              fillColor: WidgetStateProperty.resolveWith(
                                (states) => Colors.white,
                              ),
                              checkColor: Colors.blue,
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 130),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      onPressed: _submit,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        login = LoginModel(
          emailAddress: emailAddressController.text,
          password: passwordController.text,
          newPassword: '',
          confirmPassword: '',
        );
      });
      userLogin();
    }
  }

  // Function for handling user login with API call
  Future<void> userLogin() async {
    try {
      // FormData formData = FormData.fromMap({map});
      // Send login request
      Response response = await http.postRequest(
        "${http.baseUrl}SignIn/SignIn",
        login.toJson(),
      );

      if (response.statusCode == 200) {
        log("Status code is 200");
        var vdata = response.data;
        Map<String, dynamic> data = response.data;

        if (data['Success'] == true) {
          log("Login success response received");
          errorMessage = "";

          // Check if the user needs to reset their password
          if (data['ResetPassword']) {
            log("Password reset required, navigating to reset page");
            Navigator.pushNamed(context, RouteManagerProvider.slogin);
          } else {
            log("User does not need password reset, proceeding with role navigation");

            // Extract the token and set it in LoginProvider
            String token = data['ActorID'].toString(); // Updated to String
            log("Received token: $token");
            String userRole = data['Role'].toString(); // Updated to String
            log("Received role: $userRole");
            // Ensure the user and token are set before navigating
            Provider.of<LoginProvider>(context, listen: false).setUser(
              user = User.fromJson(vdata),
              token,
            );
            Provider.of<LoginProvider>(context, listen: false)
                .loggedRole(userRole);
            log("User and token successfully set in LoginProvider");

            // Now navigate based on the user's role
            navigateBasedOnRole(data['Role']);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login Successful"),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          setState(() {
            errorMessage =
                "Failed to login: ${data['message'] ?? 'Unknown error'}";
          });
        }
      } else {
        setState(() {
          errorMessage =
              "Failed to login: ${response.data['message'] ?? 'Unknown error'}";
        });
      }
    } on DioException catch (dioError) {
      setState(() {
        errorMessage = dioError.response?.data['message'] ??
            'Login failed due to network error';
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString().replaceAll("Exception: ", "")),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Navigate based on user role
  void navigateBasedOnRole(String role) {
    switch (role) {
      case 'System Admin':
        Navigator.pushNamed(context, RouteManagerProvider.systemadminlanding);
        break;
      case 'Principal':
        Navigator.pushNamed(context, RouteManagerProvider.principallandingpage);
        break;
      case 'Teacher':
        Navigator.pushNamed(context, RouteManagerProvider.teacherp);
        break;
      case 'Parent':
        Navigator.pushNamed(context, RouteManagerProvider.parent);
        break;
      default:
        setState(() {
          errorMessage = 'Unrecognized role: $role';
        });
        break;
    }
  }
}
