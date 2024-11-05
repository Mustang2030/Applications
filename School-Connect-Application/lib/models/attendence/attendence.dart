//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'attendence.g.dart';

@JsonSerializable()
class Attendence {
  @JsonKey(name: "attendenceId")
  int? attendenceId;

  @JsonKey(name: "date")
  DateTime? date;

  @JsonKey(name: "status")
  bool? status = false;

  //Fk
  @JsonKey(name: "learnerId")
  int? learnerId;

  @JsonKey(name: "teacherId")
  int? teacherId;

  @JsonKey(name: "classId")
  int? classId;

  @JsonKey(name: "schoolId")
  int? schoolId;

  //NP
  @JsonKey(name: "teacherNP")
  Teacher? teacherNP;

  @JsonKey(name: "learnerNP")
  Learner? learnerNP;

  @JsonKey(name: "class")
  SubGrade? clas;

  @JsonKey(name: "school")
  School? school;

  Attendence({
    this.attendenceId,
    this.date,
    this.status,
    this.learnerId,
    this.teacherId,
    this.classId,
    this.schoolId,
    this.learnerNP,
    this.teacherNP,
    this.clas,
    this.school,
  });
  factory Attendence.fromJson(Map<String, dynamic> json) =>
      _$AttendenceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendenceToJson(this);

  //Getters and setters
  //
  // int get attendeceId => _attendenceId;
  // set attendenceid(int value) {
  //   _attendenceId = value;
  // }

  // bool get mondayDate => _mondayDate;
  // set mondayDate(bool value) {
  //   _mondayDate = value;
  // }

  // bool get tuesdayDate => _tuesdayDate;
  // set tuesdayDate(bool value) {
  //   _tuesdayDate = value;
  // }

  // bool get wednesdayDate => _wednesdayDate;
  // set wednesdayDate(bool value) {
  //   _wednesdayDate = value;
  // }

  // bool get thursdayDate => _thursdayDate;
  // set thursdayDate(bool value) {
  //   _thursdayDate = value;
  // }

  // bool get fridayDate => _fridayDate;
  // set fridayDate(bool value) {
  //   _fridayDate = value;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'attendenceId': attendenceId,
  //     'mondayDate': mondayDate,
  //     'tuesdayDate': tuesdayDate,
  //     'wednesdayDate': wednesdayDate,
  //     'thursdayDate': thursdayDate,
  //     'fridayDate': fridayDate,
  //   };
  // }

  // factory Report.fromMap(Map<String, dynamic> map) {
  //   return Report(
  //       attendenceId: map['attendanceId'],
  //       mondayDate: bool.parse(map['mondayDate']),
  //       tuesdayDate: bool.parse(map['tuesdayDate']),
  //       wednesdayDate: bool.parse(map['wednesdayDate']),
  //       thursdayDate: bool.parse(map['thursdayDate']),
  //       fridayDate: bool.parse(map['fridayDate']));
  // }
}
