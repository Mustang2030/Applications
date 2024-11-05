//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'teach_mk_attendance.g.dart';

@JsonSerializable()
class TeachMkAttendance {
  @JsonKey(name: "teacher")
  Teacher? teacher;

  @JsonKey(name: "attendanceRecords")
  List<Attendence>? attendanceRecords;

  TeachMkAttendance({
    this.teacher,
    this.attendanceRecords,
  });
  factory TeachMkAttendance.fromMap(Map<String, dynamic> json) =>
      _$TeachMkAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$TeachMkAttendanceToJson(this);
}
