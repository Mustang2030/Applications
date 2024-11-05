import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/group/group.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/address.dart';
import 'package:scs/models/systemAdmin/systemadmin.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "emisNumber")
  String? emisNumber;

  @JsonKey(name: "logo")
  String? logo;

  @JsonKey(name: "schoolLogoFile", includeToJson: false, includeFromJson: false)
  MultipartFile? schoolLogoFile;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "dateRegistered", defaultValue: DateTime.now)
  DateTime? dateregistered;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "telePhoneNumber")
  int? telephoneNumber;

  @JsonKey(name: "emailAddress")
  String? emailAddress;

  //Foreign Keys
  @JsonKey(name: "systemAdminId")
  int? systemAdminId;

  // School.all([
  //   this.id,
  //   this.emisNumber,
  //   this.logo,
  //   this.name,
  //   this.dateregistered,
  //   this.type,
  //   //Verify if these should be nullable
  //   this.systemAdminId,
  //   this.schoolAddress,
  //   this.schoolLearnersNP,
  //   this.schoolPrincipalNP,
  //   this.schoolTeachersNP,
  //   this.schoolAnnouncementNP,
  //   this.schoolGroupsNP,
  //   this.schoolSysAdminNP,
  // ]);

  School({
    this.id,
    this.emisNumber,
    this.logo,
    this.name,
    this.dateregistered,
    this.type,
    this.telephoneNumber,
    this.emailAddress,
    //Verify if these should be nullable
    this.systemAdminId,
    this.schoolAddress,
    this.schoolLearnersNP,
    this.schoolPrincipalNP,
    this.schoolTeachersNP,
    this.schoolAnnouncementNP,
    this.schoolGroupsNP,
    this.schoolSysAdminNP,
    this.schoolLogoFile,
    this.attendanceRecords,
  });

  //Navigation Properties or Relationships
  @JsonKey(name: "schoolAddress")
  Address? schoolAddress; // One and only one

  @JsonKey(name: "schoolLearnersNP")
  List<Learner>? schoolLearnersNP; //One to many

  @JsonKey(name: "schoolTeachersNP")
  List<Teacher>? schoolTeachersNP; //One to many

  @JsonKey(name: "schoolAnnouncementNP")
  List<Announcement>? schoolAnnouncementNP;

  @JsonKey(name: "schoolSysAdminNP")
  SystemAdmin? schoolSysAdminNP;

  @JsonKey(name: "schoolGroupsNP")
  List<Group>? schoolGroupsNP;

  @JsonKey(name: "schoolPrincipalNP")
  Principal? schoolPrincipalNP; //One to one

  @JsonKey(name: "attendanceRecords")
  List<Attendence>? attendanceRecords; //One to one

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'emisNo': emisNo,
  //       'logo': logo,
  //       'name': name,
  //       'dateregistered': dateregistered,
  //       'type': type,
  //       'systemAdminId': systemAdminId,
  //       'schoolAddress': schoolAddress,
  //       'schoolLearnersNP': schoolLearnersNP,
  //       'schoolPrincipalNP': schoolPrincipalNP,
  //       'schoolTeachersNP': schoolTeachersNP,
  //     };

  // factory School.fromJson(Map<String, dynamic> json) {
  //   return School(
  //       id: json['id'],
  //       emisNo: json['emisNo'],
  //       logo: json['logo'],
  //       name: json['name'],
  //       dateregistered: DateTime.parse(json['dateRegistered']),
  //       type: json['type'],
  //       systemAdminId: json['systemAdminId'],
  //       schoolAddress: json['address'],
  //       schoolLearnersNP: json['schoolLearnersNP'],
  //       schoolPrincipalNP: json['schoolPrincipal'],
  //       schoolTeachersNP: json['schoolTeachersNP']);
  // }

  // int get id => _id;
  // set id(int value) {
  //   _id = value;
  // }

  // int get emisNo => _emisNo;
  // set emisNo(int value) {
  //   _emisNo = value;
  // }

  // String get logo => _logo;
  // set logo(String value) {
  //   _logo = value;
  // }

  // String get name => _name;
  // set name(String value) {
  //   _name = value;
  // }

  // DateTime get dateregistered => _dateregistered;
  // set dateRegistered(DateTime value) {
  //   _dateregistered = value;
  // }

  // String get type => _type;
  // set type(String value) {
  //   _type = value;
  // }

  // int get systemAdminId => _systemAdminId;
  // set systemAdminId(int value) {
  //   _systemAdminId = value;
  // }

  // Address get schoolAddress => _schoolAddress;
  // set schoolAddress(Address value) {
  //   schoolAddress = value;
  // }

  // List<Learner> get schoolLearnersNP => _schoolLearnersNP;
  // set schoolLearnersNP(List<Learner> value) {
  //   _schoolLearnersNP = value;
  // }

  // List<Teacher> get schoolTeachersNP => _schoolTeachersNP;
  // set schoolTeachersNP(List<Teacher> value) {
  //   _schoolTeachersNP = value;
  // }

  // Principal get schoolPricipalNP => _schoolPrincipalNP;
  // set schoolPrincipalNP(Principal value) {
  //   _schoolPrincipalNP = value;
  // }
}
