import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/misc/validators.dart';
import 'package:scs/models/loginmodel/loginmodel.dart';
import 'package:scs/services/http_service.dart';

class SLogin extends StatefulWidget {
  const SLogin({super.key});

  @override
  State<SLogin> createState() => _SLoginState();
}

class _SLoginState extends State<SLogin> {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  LoginModel login = LoginModel(
      emailAddress: "", password: "", newPassword: "", confirmPassword: "");
  late HttpService http;

  @override
  void initState() {
    http = HttpService();
    super.initState();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 34, 41, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2E34),
        leading: IconButton(
          color: kTextColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pexels.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
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
                        validator: validateEmail,
                        textStyle: const TextStyle(color: Colors.white),
                        decoration: formS(
                            "Email", 'Write Email Here', Icons.email,
                            borderColor: Colors.white,
                            iconColor: Colors.white,
                            labelTextColor: Colors.white,
                            hintTextColor: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      StyledFormField(
                        controller: oldPasswordController,
                        textStyle: const TextStyle(color: Colors.white),
                        isPassword: true,
                        decoration: formS("Old Password", 'Write you old here',
                            Icons.password_sharp,
                            borderColor: Colors.white,
                            iconColor: Colors.white,
                            labelTextColor: Colors.white,
                            hintTextColor: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      StyledFormField(
                        controller: newPasswordController,
                        isPassword: true,
                        textStyle: const TextStyle(color: Colors.white),
                        decoration: formS(
                            "New Password",
                            'Write your new password here',
                            Icons.password_sharp,
                            borderColor: Colors.white,
                            iconColor: Colors.white,
                            labelTextColor: Colors.white,
                            hintTextColor: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      StyledFormField(
                        controller: confirmPasswordController,
                        textStyle: const TextStyle(color: Colors.white),
                        isPassword: true,
                        decoration: formS(
                            "Confirm Password",
                            'Re-Type your new password here',
                            Icons.password_sharp,
                            borderColor: Colors.white,
                            iconColor: Colors.white,
                            labelTextColor: Colors.white,
                            hintTextColor: Colors.white),
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
                          'Change Password',
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
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Add password change logic here
      if (newPasswordController != confirmPasswordController) {
        setState(() {
          login = LoginModel(
              emailAddress: emailAddressController.text,
              password: oldPasswordController.text,
              newPassword: newPasswordController.text,
              confirmPassword: confirmPasswordController.text);
        });
        userChangePassword();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Password changed successfully')),
        );
      }
    }
  }

  Future<void> userChangePassword() async {
    try {
      Response response = await http.putRequest(
        "${http.baseUrl}SignIn/SetNewPassword",
        login.toJson(),
      );
      log("This is the statusCode that is being returned ${response.statusCode}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        Navigator.pop(context);
        log("Password change successful");
        var data = response.data;
        if (data['Success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password reset successful. Please log in."),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        setState(() {
          errorMessage =
              response.data['message'] ?? 'Failed to reset password.';
        });
      }
    } on DioException catch (dioError) {
      log("DioError occurred: ${dioError.response?.data}");
      setState(() {
        errorMessage = handleDioError(dioError) ?? 'Network error';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(e.toString().replaceAll("Exception:", ""))),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
