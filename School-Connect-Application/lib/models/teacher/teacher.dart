import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/announcement/announcement.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/baseactor/baseactor.dart';
import 'package:scs/models/groupactor/groupactors.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/models/teachergrade/teachergrade.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher extends BaseActor {
  @JsonKey(name: "staffNr")
  String? staffNr;

  @JsonKey(name: "subjects")
  List<String>? subjects;

  @JsonKey(name: "phoneNumber")
  int? phoneNumber;

  @JsonKey(name: "emailAddress")
  String? emailAddress;

  //Foreign key
  @JsonKey(name: "schoolID")
  int? schoolID;

  //Navigation Properties
  @JsonKey(name: "mainClass")
  SubGrade? mainClass;

  @JsonKey(name: "classes")
  List<TeacherGrade>? classes;

  @JsonKey(name: "teacherSchoolNP")
  School? teacherSchoolNP;

  @JsonKey(name: "groupNP")
  List<GroupActors>? groupNP;

  @JsonKey(name: "announcementNP")
  List<Announcement>? announcementNP;

  @JsonKey(name: "attendanceRecords")
  List<Attendence>? attendanceRecords; //One to one

  Teacher({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.role,
    super.title,
    this.staffNr,
    this.mainClass,
    this.classes,
    this.subjects,
    this.phoneNumber,
    this.emailAddress,
    this.schoolID,
    this.announcementNP,
    this.groupNP,
    this.teacherSchoolNP,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
