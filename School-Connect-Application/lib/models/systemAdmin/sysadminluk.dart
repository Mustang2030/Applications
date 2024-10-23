// import 'package:practice/models/baseactor/base_actor.dart';
// import 'package:practice/models/baseactor/baseactor.dart';
// import 'package:practice/models/school/school.dart';
// import 'package:json_annotation/json_annotation.dart';

// class SystemAdminL extends BaseActorP {
//   @JsonKey(name: "staffNr")
//   int? staffNr;

//   @JsonKey(name: "emailAddress")
//   String? emailAddress;

//   @JsonKey(name: "phoneNumber")
//   int? phoneNumber;

//   // Navigating properties
//   School? sysAdminSchoolNP;

//   // Constructor with optional parameters
//   SystemAdminL({
//     super.id,
//     super.profileImage,
//     super.name,
//     super.surname,
//     super.gender,
//     super.role,
//     this.staffNr,
//     this.phoneNumber,
//     this.emailAddress,
//     this.sysAdminSchoolNP,
//   });

//   // Create a SystemAdmin from JSON
//   factory SystemAdminL.fromJson(Map<String, dynamic> json) => SystemAdminL(
//         id: json['Id'],
//         name: json['Name'],
//         surname: json['Surname'],
//         profileImage: json['ProfileImage'],
//         gender: json['Gender'],
//         role: json['Role'],
//         staffNr: json['StaffNr'],
//         phoneNumber: json['PhoneNumber'],
//         emailAddress: json['EmailAddress'],
//         sysAdminSchoolNP: json['sysAdminSchoolNP'] != null
//             ? School.fromJson(json['sysAdminSchoolNP'])
//             : null,
//       );

//   // Convert SystemAdmin to JSON

//   @override
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'surname': surname,
//         'profileImage': profileImage,
//         'gender': gender,
//         'role': role,
//         'staffNr': staffNr,
//         'phoneNumber': phoneNumber,
//         'emailAddress': emailAddress,
//         'sysAdminSchoolNP': sysAdminSchoolNP?.toJson(),
//       };
// }
