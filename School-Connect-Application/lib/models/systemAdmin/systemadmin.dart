import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/baseactor/baseactor.dart';
import 'package:scs/models/school/school.dart';

part 'systemadmin.g.dart';

@JsonSerializable()
class SystemAdmin extends BaseActor {
  @JsonKey(name: "staffNr")
  String? staffNr;

  @JsonKey(name: "emailAddress")
  String? emailAddress;

  @JsonKey(name: "phoneNumber")
  int? phoneNumber;

  // Navigating properties
  School? sysAdminSchoolNP;

  // Constructor with optional parameters
  SystemAdmin({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.title,
    super.role,
    this.staffNr,
    this.phoneNumber,
    this.emailAddress,
    this.sysAdminSchoolNP,
  });

  factory SystemAdmin.fromJson(Map<String, dynamic> json) =>
      _$SystemAdminFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SystemAdminToJson(this);

  // // Create a SystemAdmin from JSON
  // factory SystemAdmin.fromJson(Map<String, dynamic> json) => SystemAdmin(
  //       id: json['Id'],
  //       name: json['Name'],
  //       surname: json['Surname'],
  //       profileImage: json['ProfileImage'],
  //       gender: json['Gender'],
  //       role: json['Role'],
  //       staffNr: json['StaffNr'],
  //       phoneNumber: json['PhoneNumber'],
  //       emailAddress: json['EmailAddress'],
  //       sysAdminSchoolNP: json['sysAdminSchoolNP'] != null
  //           ? School.fromJson(json['sysAdminSchoolNP'])
  //           : null,
  //     );

  // // Convert SystemAdmin to JSON

  // @override
  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'surname': surname,
  //       'profileImage': profileImage,
  //       'gender': gender,
  //       'role': role,
  //       'staffNr': staffNr,
  //       'phoneNumber': phoneNumber,
  //       'emailAddress': emailAddress,
  //       'sysAdminSchoolNP': sysAdminSchoolNP?.toJson(),
  //     };
}
