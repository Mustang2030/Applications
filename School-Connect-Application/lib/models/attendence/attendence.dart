//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'attendence.g.dart';

@JsonSerializable()
class Attendence {
  @JsonKey(name: "attendenceId")
  int attendenceId;

  @JsonKey(name: "mondayDate")
  bool mondayDate;

  @JsonKey(name: "tuesdayDate")
  bool tuesdayDate;

  @JsonKey(name: "wednesdayDate")
  bool wednesdayDate;

  @JsonKey(name: "thursdayDate")
  bool thursdayDate;

  @JsonKey(name: "fridayDate")
  bool fridayDate;

  //Fk
  @JsonKey(name: "learnerId")
  int learnerId;

  @JsonKey(name: "teacherId")
  int teacherId;

  //NP
  @JsonKey(name: "learnerNP")
  Learner learnerNP;

  @JsonKey(name: "teacherNP")
  Teacher teacherNP;

  Attendence({
    required this.attendenceId,
    required this.mondayDate,
    required this.tuesdayDate,
    required this.wednesdayDate,
    required this.thursdayDate,
    required this.fridayDate,
    required this.learnerId,
    required this.teacherId,
    required this.learnerNP,
    required this.teacherNP,
  });
  factory Attendence.fromMap(Map<String, dynamic> json) =>
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
