import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/services/http_service.dart';

class RoleRegistration extends StatefulWidget {
  const RoleRegistration({super.key});

  @override
  State<RoleRegistration> createState() => _RoleRegistrationState();
}

class _RoleRegistrationState extends State<RoleRegistration> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController staffNrController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emisController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController learnerIDController = TextEditingController();

  //Learner controllers
  final TextEditingController titleControllerL = TextEditingController();
  final TextEditingController nameControlerL = TextEditingController();
  final TextEditingController surnameControllerL = TextEditingController();
  String selectedGenderL = "Male";
  String selectedTitleL = "Mr";
  List<String> subjectListL = [];

  String errorMessage = "";

  School school = School();
  Principal principal = Principal();
  Teacher teacher = Teacher();
  Learner learner = Learner(parents: []);
  Parent parent = Parent();
  SystemAdmin systemAdmin = SystemAdmin();
  LearnerParent learnerParent = LearnerParent();
  List<School> schools = [];

  String selectedRole = "Principal"; // Default selection
  String selectedGender = "Male";
  String selectedParentType = "Mother";
  String selectedTitle = "Mr";
  List<String> subjectList = [];
  List<String> classIdes = [];
  String classCode = "";
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  File? _selectedLearnerImage;
  File? _selectedExcelFile;
  late HttpService http;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getAdmin('SystemAdmin/GetSystemAdminById?id=');
    getSchools("School/GetSchoolByAdminId?adminId=");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2E34),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        "Register Roles here ${systemAdmin.name} ${systemAdmin.surname}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F2E34),
                        ),
                      ),
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                      ),
                      Column(
                        children: [
                          StyledFormField(
                            isDropdown: true,
                            selectedItem: selectedRole,
                            dropdownItems: const [
                              "Teacher",
                              "Parent",
                              "Principal",
                              "Learner",
                              //Model will be assigned to the selected item.
                            ],
                            onChanged: (selectedItem) {
                              setState(() {
                                selectedRole = selectedItem;
                              });
                            },
                            decoration: formS(
                              "Role",
                              "",
                              Icons.account_circle_sharp,
                              iconColor: const Color(0xFF0F2E34),
                            ),
                          ),
                          // Conditionally show the MultiSelectFormField based on the selected role
                          //Teacher
                          Column(
                            children: [
                              // Other fields like name, surname, etc.
                              if (selectedRole == "Teacher") ...[
                                rslButton(context, "Profile Image", () {
                                  pickImage();
                                }),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedTitle,
                                  dropdownItems: const ["Mr", "Mrs", "Miss"],
                                  decoration: formS(
                                      "Title", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedTitle = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: nameControler,
                                  decoration: formS("Name", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: surnameController,
                                  decoration: formS(
                                      "Surname", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),

                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedGender,
                                  dropdownItems: const ["Male", "Female"],
                                  decoration: formS(
                                      "Gender", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedGender = selectedItem;
                                    });
                                  },
                                ),
                                // MainClass Dropdown
                                // StyledFormField(
                                //   isDropdown: true,
                                //   readonly: true,
                                //   dropdownItems: const [
                                //     "8A",
                                //     "9A",
                                //     "10A",
                                //     "11A",
                                //     "12A",
                                //   ],
                                //   onChanged: (mainCl) {
                                //     setState(() {
                                //       classCode = mainCl;
                                //     });
                                //   },
                                //   decoration: formS(
                                //       "MainClass", "Select Main Class", Icons.school),
                                // ),
                                StyledFormField(
                                  controller: staffNrController,
                                  decoration: formS(
                                      "Staff Number", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: emailController,
                                  decoration: formS(
                                      "Email", "", Icons.email_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: phoneNumberController,
                                  decoration: formS(
                                      "Phone Number", "", Icons.phone,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),

                                // MultiSelectDialogField(
                                //   buttonIcon: const Icon(Icons.subject),
                                //   buttonText: const Text("Classes Taught"),
                                //   searchable: true,
                                //   isDismissible: true,
                                //   selectedColor: Colors.black87,
                                //   items: [
                                //     MultiSelectItem("8A", "8A"),
                                //     MultiSelectItem("9B", "9B"),
                                //     MultiSelectItem("10A", "10A"),
                                //     MultiSelectItem("10B", "10B"),
                                //     MultiSelectItem("11A", "11A"),
                                //     MultiSelectItem("11B", "11B"),
                                //     MultiSelectItem("12A", "12A"),
                                //   ],
                                //   onConfirm: (values) {
                                //     setState(() {
                                //       classIdes = values;
                                //     });
                                //   },
                                //   title: const Text("Select Classes Taught"),
                                //   decoration: const BoxDecoration(
                                //     color: Colors.black38,
                                //     border: Border(),
                                //     borderRadius: BorderRadius.all(Radius.circular(9)),
                                //   ),
                                // ),
                                // const SizedBox(height: 20),
                                // MultiSelectFormField for selecting subjects
                                MultiSelectDialogField(
                                  buttonIcon: const Icon(Icons.book),
                                  buttonText: const Text("Subjects Taught"),
                                  searchable: true,
                                  isDismissible: true,
                                  selectedColor: Colors.black87,
                                  items: [
                                    MultiSelectItem("English", "English"),
                                    MultiSelectItem(
                                        "Mathematics", "Mathematics"),
                                    MultiSelectItem(
                                        "Social Sciences", "Social Sciences"),
                                    MultiSelectItem("Economics", "Economics"),
                                    MultiSelectItem("Afrikaans", "Afrikaans"),
                                    MultiSelectItem(
                                        "Life Orientation", "Life Orientation"),
                                    MultiSelectItem(
                                        "Life Skills", "Life Skills"),
                                  ],
                                  onConfirm: (values) {
                                    setState(() {
                                      subjectList = values;
                                    });
                                  },
                                  title: const Text("Select Subjects"),
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9)),
                                  ),
                                ),
                                if (_selectedExcelFile != null)
                                  Image.asset(
                                    "assets/images/excel.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                slButton(context, "Batch Register", () {
                                  pickExcelFile();
                                }),

                                rslButton(
                                    context,
                                    isLoading ? "Loading..." : "Load Teachers",
                                    isLoading
                                        ? () {}
                                        : () {
                                            batchRegisterTeachers();
                                          }),
                                const SizedBox(height: 10)
                              ],
                            ],
                          ),
                          //Principal
                          Column(
                            children: [
                              if (selectedRole == "Principal") ...[
                                if (_selectedImage != null)
                                  Image.file(
                                    _selectedImage!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                rslButton(context, "Profile Image", () {
                                  pickImage();
                                }),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedTitle,
                                  dropdownItems: const ["Mr", "Mrs", "Miss"],
                                  decoration: formS(
                                      "Title", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedTitle = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: nameControler,
                                  decoration: formS("Name", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: surnameController,
                                  decoration: formS(
                                      "Surname", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedGender,
                                  dropdownItems: const ["Male", "Female"],
                                  decoration: formS(
                                      "Gender", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedGender = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: staffNrController,
                                  decoration: formS(
                                      "Staff Number", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: emailController,
                                  decoration: formS(
                                      "Email", "", Icons.email_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: phoneNumberController,
                                  decoration: formS(
                                      "Phone Number", "", Icons.phone,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                              ]
                            ],
                          ),
                          //Parent
                          Column(
                            children: [
                              if (selectedRole == "Parent") ...[
                                rslButton(context, "Profile Image", () {
                                  pickImage();
                                }),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedTitle,
                                  dropdownItems: const ["Mr", "Mrs", "Miss"],
                                  decoration: formS(
                                      "Title", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedTitle = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: nameControler,
                                  decoration: formS("Name", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: surnameController,
                                  decoration: formS(
                                      "Surname", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedGender,
                                  dropdownItems: const ["Male", "Female"],
                                  decoration: formS(
                                      "Gender", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedGender = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: idController,
                                  decoration: formS("Parent ID Number", "",
                                      Icons.numbers_rounded,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: learnerIDController,
                                  decoration: formS("Child ID Number", "",
                                      Icons.numbers_rounded,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: emailController,
                                  decoration: formS(
                                      "Email", "", Icons.email_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: phoneNumberController,
                                  decoration: formS(
                                      "Phone Number", "", Icons.phone,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedParentType,
                                  dropdownItems: [
                                    "Mother",
                                    "Father",
                                    "Guardian"
                                  ],
                                  onChanged: (selectedItem) {
                                    selectedParentType = selectedItem;
                                  },
                                  decoration: formS("Parent Type", "",
                                      Icons.roller_skating_outlined,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                if (_selectedExcelFile != null)
                                  Image.asset(
                                    "assets/images/excel.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                slButton(
                                    context,
                                    isLoading
                                        ? "Loading..."
                                        : "Select Parents Excel",
                                    isLoading
                                        ? () {}
                                        : () {
                                            pickExcelFile();
                                          }),
                                rslButton(
                                    context,
                                    isLoading
                                        ? "Loading..."
                                        : "Register Parents",
                                    isLoading
                                        ? () {}
                                        : () {
                                            batchRegisterParents();
                                          }),
                                const SizedBox(height: 10)
                              ]
                            ],
                          ),
                          //Learner
                          Column(
                            children: [
                              if (selectedRole == "Learner") ...[
                                if (_selectedLearnerImage != null)
                                  Image.file(
                                    _selectedLearnerImage!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                // Image picker button
                                rslButton(context, "Learner Profile Image", () {
                                  pickImage();
                                }),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedTitleL,
                                  dropdownItems: const ["Mr", "Miss"],
                                  decoration: formS(
                                      "Title", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedTitleL = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: nameControlerL,
                                  decoration: formS("Name", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: surnameControllerL,
                                  decoration: formS(
                                      "Surname", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),

                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedGenderL,
                                  dropdownItems: const ["Male", "Female"],
                                  decoration: formS(
                                      "Gender", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedGenderL = selectedItem;
                                    });
                                  },
                                ),

                                // MainClass Dropdown
                                StyledFormField(
                                  isDropdown: true,
                                  readonly: true,
                                  dropdownItems: [
                                    //Rememeber to check the logic on this one.
                                    if (systemAdmin.sysAdminSchoolNP!.type ==
                                        "Primary") ...[
                                      "1A",
                                      "2A",
                                      "3A",
                                      "4A",
                                      "5A",
                                      "6A",
                                      "7A"
                                    ] else if (systemAdmin
                                            .sysAdminSchoolNP!.type ==
                                        "High") ...[
                                      "8A",
                                      "9A",
                                      "10A",
                                      "11A",
                                      "12A",
                                    ] else if (systemAdmin
                                            .sysAdminSchoolNP!.type ==
                                        "Combined") ...[
                                      "1A",
                                      "2A",
                                      "3A",
                                      "4A",
                                      "5A",
                                      "6A",
                                      "7A",
                                      "8A",
                                      "9A",
                                      "10A",
                                      "11A",
                                      "12A"
                                    ]
                                  ],
                                  onChanged: (mainCl) {
                                    setState(() {
                                      classCode = mainCl;
                                    });
                                  },
                                  decoration: formS("Main Class",
                                      "Select Main Class", Icons.school,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                MultiSelectDialogField(
                                  buttonIcon: const Icon(Icons.book),
                                  buttonText: const Text("Subjects Taught"),
                                  searchable: true,
                                  isDismissible: true,
                                  selectedColor: Colors.black87,
                                  items: [
                                    MultiSelectItem("English", "English"),
                                    MultiSelectItem(
                                        "Mathematics", "Mathematics"),
                                    MultiSelectItem(
                                        "Social Sciences", "Social Sciences"),
                                    MultiSelectItem("Economics", "Economics"),
                                    MultiSelectItem("Afrikaans", "Afrikaans"),
                                    MultiSelectItem(
                                        "Life Orientation", "Life Orientation"),
                                    MultiSelectItem(
                                        "Life Skills", "Life Skills"),
                                  ],
                                  onConfirm: (values) {
                                    setState(() {
                                      subjectList = values;
                                    });
                                  },
                                  title: const Text("Select Subjects"),
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9)),
                                  ),
                                ),
                                if (_selectedExcelFile != null)
                                  Image.asset(
                                    "assets/images/excel.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                slButton(
                                    context,
                                    isLoading ? "Loading..." : "Load Learners",
                                    isLoading
                                        ? () {}
                                        : () {
                                            pickExcelFile();
                                          }),

                                rslButton(
                                    context,
                                    isLoading
                                        ? "Loading..."
                                        : "Submit Loaded Learners",
                                    isLoading
                                        ? () {}
                                        : () {
                                            batchRegisterLearners();
                                          }),
                                const SizedBox(height: 10),
                                const Text(
                                  "Parent Registration",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F2E34),
                                  ),
                                ),

                                if (_selectedImage != null) ...[
                                  Image.file(
                                    _selectedImage!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                                // Image picker button
                                rslButton(
                                  context,
                                  "Parent Profile Image",
                                  () {
                                    parentChildImage();
                                  },
                                ),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedTitle,
                                  dropdownItems: const ["Mr", "Mrs", "Miss"],
                                  decoration: formS(
                                      "Title", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedTitle = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: nameControler,
                                  decoration: formS("Name", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: surnameController,
                                  decoration: formS(
                                      "Surname", "", Icons.abc_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),

                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedGender,
                                  dropdownItems: const ["Male", "Female"],
                                  decoration: formS(
                                      "Gender", "", Icons.account_circle_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      selectedGender = selectedItem;
                                    });
                                  },
                                ),
                                StyledFormField(
                                  controller: idController,
                                  decoration: formS("Parent ID Number", "",
                                      Icons.numbers_rounded,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: learnerIDController,
                                  decoration: formS("Child ID Number", "",
                                      Icons.numbers_rounded,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: emailController,
                                  decoration: formS(
                                      "Email", "", Icons.email_sharp,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  controller: phoneNumberController,
                                  decoration: formS(
                                      "Phone Number", "", Icons.phone,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                                StyledFormField(
                                  isDropdown: true,
                                  selectedItem: selectedParentType,
                                  dropdownItems: [
                                    "Mother",
                                    "Father",
                                    "Guardian"
                                  ],
                                  onChanged: (selectedItem) {
                                    selectedParentType = selectedItem;
                                  },
                                  decoration: formS("Parent Type", "",
                                      Icons.roller_skating_outlined,
                                      iconColor: const Color(0xFF0F2E34)),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      rslButton(
                        context,
                        isLoading ? "REGISTERING..." : "REGISTER",
                        isLoading
                            ? () {}
                            : () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (selectedRole == "Principal") {
                                  registerPrincipal();
                                } else if (selectedRole == "Teacher") {
                                  registerTeacher();
                                } else if (selectedRole == "Learner") {
                                  registerLearner();
                                } else if (selectedRole == "Parent") {
                                  registerParent();
                                }
                              },
                      ),
                      if (isLoading) const CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // Principle registration
  Future<void> registerPrincipal() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Teacher");

      FormData formData = FormData.fromMap({
        'id': 0,
        'title': selectedTitle,
        'name': nameControler.text,
        'surname': surnameController.text,
        'gender': selectedGender,
        'role': selectedRole,
        'staffNr': staffNrController.text,
        'emailAddress': emailController.text,
        'phoneNumber': int.tryParse(phoneNumberController.text),
        'schoolID': systemAdmin.sysAdminSchoolNP!.schoolAddress!.schoolID,
        'profileImageFile': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),
      });

      Response response =
          await http.postRequest("${http.baseUrl}Principal/Create/", formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully a principal"),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Failed to register the principal. Please try again."),
          ),
        );
      }

      // Pass FormData directly to the postRequest
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the principal"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Teacher Registration
  Future<void> registerTeacher() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Teacher");

      FormData formData = FormData.fromMap({
        'id': 0,
        'title': selectedTitle,
        'name': nameControler.text,
        'surname': surnameController.text,
        'gender': selectedGender,
        'role': selectedRole,
        'staffNr': staffNrController.text,
        'emailAddress': emailController.text,
        'phoneNumber': int.tryParse(phoneNumberController.text),
        'schoolID': systemAdmin.sysAdminSchoolNP!.id,
        'subjects': subjectList,
        'classes': null,
        'mainClass': null,
        'groupNP': null,
        'teacherSchoolNP': null,
        'announcementNP': null,
        'profileImageFile': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),
      });

      Response response =
          await http.postRequest("${http.baseUrl}Teacher/Create/", formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully a teacher"),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the learner. Please try again."),
          ),
        );
      }

      // Pass FormData directly to the postRequest
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the learner"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Learner Registration
  Future<void> registerLearner() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Learner");

      FormData formData = FormData.fromMap({
        //Learner Data
        'learner.id': 0,
        'learner.title': selectedTitleL,
        'learner.name': nameControlerL.text,
        'learner.surname': surnameControllerL.text,
        'learner.gender': selectedGenderL,
        'learner.role': selectedRole,
        'learner.idNo': learnerIDController.text,
        'learner.schoolID':
            systemAdmin.sysAdminSchoolNP!.schoolAddress!.schoolID,
        'learner.subjects': subjectList,
        'learner.classID': 0,
        'learner.classCode': classCode,
        'learner.profileImageFile': await MultipartFile.fromFile(
          _selectedLearnerImage!.path,
          filename: _selectedLearnerImage!.path.split('/').last,
        ),

        //LearnerParent relationship
        'learner.parents[0].learnerId': 0,
        'learner.parents[0].parentId': 0,
        'learner.parents[0].learnerIdNo': learnerIDController.text,
        'learner.parents[0].parentIdNo': idController.text,

        //Parent data
        'learner.parents[0].parent.id': 0,
        'learner.parents[0].parent.title': selectedTitle,
        'learner.parents[0].parent.name': nameControler.text,
        'learner.parents[0].parent.surname': surnameController.text,
        'learner.parents[0].parent.gender': selectedGender,
        'learner.parents[0].parent.role': "Parent",
        'learner.parents[0].parent.idNo': idController.text,
        'learner.parents[0].parent.parentType': selectedParentType,
        'learner.parents[0].parent.emailAddress': emailController.text,
        'learner.parents[0].parent.phoneNumber':
            int.tryParse(phoneNumberController.text),
        'learner.parents[0].parent.profileImageFile':
            await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),

        //LearnerParent
        'learner.parents[0].parent.children.learnerId': 0,
        'learner.parents[0].parent.children.parentId': 0,
        'learner.parents[0].parent.children.learnerIdNo':
            learnerIDController.text,
        'learner.parents[0].parent.children.parentIdNo': idController.text,
      });

      Response response =
          await http.postRequest("${http.baseUrl}Learner/Create/", formData);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Learner registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully registered a learner"),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the learner. Please try again."),
          ),
        );
      }

      // Pass FormData directly to the postRequest
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the parent"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Parent Registration
  Future<void> registerParent() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Parent");

      FormData formData = FormData.fromMap({
        'parent.id': 0,
        'parent.title': selectedTitle,
        'parent.name': nameControler.text,
        'parent.surname': surnameController.text,
        'parent.gender': selectedGender,
        'parent.role': selectedRole,
        'parent.idNo': idController.text,
        'parent.parentType': selectedParentType,
        'parent.emailAddress': emailController.text,
        'parent.phoneNumber': int.tryParse(phoneNumberController.text),

        //LearnerParent
        'parent.children[0].learnerId': 0,
        'parent.children[0].parentId': 0,
        'parent.children[0].learnerIdNo': learnerIDController.text,
        'parent.children[0].parentIdNo': idController.text,
        'profileImageFile': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),
      });

      Response response =
          await http.postRequest("${http.baseUrl}Parent/Create/", formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully a parent"),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the parent. Please try again."),
          ),
        );
      }

      // Pass FormData directly to the postRequest
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the parent"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Recieve Admin info
  Future<void> getAdmin(String url) async {
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

  // Get School
  Future<void> getSchools(String url) async {
    String? token = Provider.of<LoginProvider>(context, listen: false).token;

    setState(() {
      isLoading = true;
    });
    try {
      log("Fetching schools");
      log("The school ID is : ${school.id}");

      // Making the API request
      Response response = await http.getRequest("${http.baseUrl}$url$token");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        // Log the response to check its format
        log("Response data: ${response.data}");

        // Check if the response data is a list
        if (response.data['Success'] is List) {
          log("A list is returned");
          var result = response.data['Result'] as List;
          // Map the result to the list of School objects
          setState(() {
            schools = result.map((json) => School.fromJson(json)).toList();
            log("Schools fetched: ${schools.length}");
            isLoading = false;
          });
        } else if (response.data['Success'] is Map) {
          log("A Map is returned");
          // Handle the case where it's a single school object
          setState(() {
            school = School.fromJson(response.data);
            schools = [school]; // Add single school to the list
            isLoading = false;
          });
        } else {
          log("Unexpected response format: ${response.data}");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        log("Problem, statusCode ${response.statusCode}, message ${response.statusMessage}");
        setState(() {
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      log("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load schools: $e')),
      );
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Register multiple learners at once.
  Future<void> batchRegisterLearners() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Learners");

      // Ensure _selectedExcelFile is not null
      if (_selectedExcelFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select an Excel file."),
          ),
        );
        return; // Exit early if no file is selected
      }

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _selectedExcelFile!.path, // Use the full file path
          filename:
              _selectedExcelFile!.path.split('/').last, // Set the filename
        ),
      });

      // Send the POST request
      Response response = await http.postRequest(
          "${http.baseUrl}Learner/LoadLearnersFromExcel/?schoolId=${systemAdmin.sysAdminSchoolNP!.id}",
          formData);

      // Check for successful response
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Learners registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully registered all the learners."),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the learners. Please try again."),
          ),
        );
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the learners."),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Register multiple parents at once.
  Future<void> batchRegisterParents() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Parents");

      // Ensure _selectedExcelFile is not null
      if (_selectedExcelFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select an Excel file."),
          ),
        );
        return; // Exit early if no file is selected
      }

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _selectedExcelFile!.path, // Use the full file path
          filename:
              _selectedExcelFile!.path.split('/').last, // Set the filename
        ),
      });

      // Send the POST request
      Response response = await http.postRequest(
          "${http.baseUrl}Parent/BatchLoadParentsFromExcel/", formData);

      // Check for successful response
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Parents registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully registered all the parents."),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the parents. Please try again."),
          ),
        );
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the parents."),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Register multiple teachers at once.
  Future<void> batchRegisterTeachers() async {
    setState(() {
      isLoading = true; // Enable loading state
    });
    try {
      log("Registering Teachers");

      // Ensure _selectedExcelFile is not null
      if (_selectedExcelFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select an Excel file."),
          ),
        );
        return; // Exit early if no file is selected
      }

      FormData formData = FormData.fromMap({
        'schoolId': systemAdmin.sysAdminSchoolNP!.id,
        "file": await MultipartFile.fromFile(
          _selectedExcelFile!.path, // Use the full file path
          filename:
              _selectedExcelFile!.path.split('/').last, // Set the filename
        ),
      });

      // Send the POST request
      Response response = await http.postRequest(
          "${http.baseUrl}Teacher/BulkLoadTeachersFromExcel?schoolId=${systemAdmin.sysAdminSchoolNP!.id}",
          formData);

      // Check for successful response
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log("Teachers registered");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have successfully registered all the Teachers."),
          ),
        );
        Navigator.pop(context); // Pop the screen only after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to register the teahers. Please try again."),
          ),
        );
      }
    } on DioException catch (dioError) {
      log("DioError occurred: $dioError");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register the teachers."),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Disable loading state
      });
    }
  }

  // Image picker function
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && selectedRole == "Learner") {
      setState(() {
        _selectedLearnerImage = File(image.path); // Get the correct mobile path
      });
    } else if (image != null && selectedRole != "Learner") {
      setState(() {
        _selectedImage = File(image.path); // Get the correct mobile path
      });
    }
  }

  // Excel picker function
  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'], // Restrict to Excel files
    );

    if (result != null) {
      File excelFile =
          File(result.files.single.path!); // Get the correct file path
      setState(() {
        _selectedExcelFile = excelFile; // Store the selected Excel file
      });
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No file selected"),
        ),
      );
    }
  }

  //ParentChild Profile imageSelection
  Future<void> parentChildImage() async {
    setState(() {
      selectedRole = 'Parent';
    });

    await pickImage();

    setState(() {
      selectedRole = "Learner";
    });
  }
}
