import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/baseactor/baseactor.dart';
import 'package:scs/models/school/school.dart';

part 'principal.g.dart';

@JsonSerializable()
class Principal extends BaseActor {
  @JsonKey(name: "staffNr")
  String? staffNr;

  @JsonKey(name: "emailAddress")
  String? emailAddress;

  @JsonKey(name: "phoneNumber")
  int? phoneNumber;

  //ID for school
  @JsonKey(name: "schoolID")
  int? schoolID;

  //Reference to School Object
  @JsonKey(name: "principalSchoolNP")
  School? principalSchoolNP;

  @JsonKey(name: "announcementsNP")
  Announcement? announcementsNP;

  Principal({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.title,
    super.role,
    this.staffNr,
    this.emailAddress,
    this.phoneNumber,
    this.schoolID,
    this.principalSchoolNP,
    this.announcementsNP,
  });

  factory Principal.fromJson(Map<String, dynamic> json) =>
      _$PrincipalFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PrincipalToJson(this);
  // int get staffNr => _staffNr;
  // set staffNr(int value) {
  //   _staffNr = value;
  // }

  // String get emailAddress => _emailAddress;
  // set emailAddress(String value) {
  //   _emailAddress = value;
  // }

  // int get phoneNumber => _phoneNumber;
  // set phoneNumber(int value) {
  //   _phoneNumber = value;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'staffNr': staffNr,
  //     'emailAddress': emailAddress,
  //     'phoneNumber': emailAddress,
  //   };
  // }

  // factory Principal.fromMap(Map<String, dynamic> map) {
  //   return Principal(
  //       id: map['id'],
  //       profileImage: map['profileImage'],
  //       name: map['name'],
  //       surname: map['surname'],
  //       gender: map['gender'],
  //       role: map['role'],
  //       staffNr: map['staffNr'],
  //       emailAddress: map['emailAddress'],
  //       phoneNumber: map['phoneNumber']);
  // }
}
