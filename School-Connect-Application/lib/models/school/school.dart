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

  @JsonKey(name: "schoolLogoBase64")
  String? schoolLogoBase64;

  @JsonKey(name: "profileImageType")
  String? profileImageType;

  //Foreign Keys
  @JsonKey(name: "systemAdminId")
  int? systemAdminId;

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
    this.schoolLogoBase64,
    this.profileImageType,
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
}
