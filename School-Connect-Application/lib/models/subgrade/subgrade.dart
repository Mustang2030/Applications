import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/grade/grade.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/teacher/teacher.dart';
import 'package:scs/models/teachergrade/teachergrade.dart';

part 'subgrade.g.dart';

@JsonSerializable()
class SubGrade {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "classDesignate")
  String? classDesignate;

  @JsonKey(name: "subjectsTaught")
  List<String>? subjectsTaught;

  //Foreign Key
  @JsonKey(name: "mainTeacherId")
  int? mainTeacherId;

  @JsonKey(name: "gradeId")
  int? gradeId;

  //Navigation Properties
  @JsonKey(name: "learners")
  List<Learner>? learners;

  @JsonKey(name: "mainTeacher")
  Teacher? mainTeacher;

  @JsonKey(name: "teachers")
  List<TeacherGrade>? teachers;

  @JsonKey(name: "grade")
  Grade? grade;

  @JsonKey(name: "attendanceRecords")
  List<Attendence>? attendanceRecords;

  SubGrade(
      {this.id,
      this.classDesignate,
      this.mainTeacherId,
      this.gradeId,
      this.grade,
      this.learners,
      this.mainTeacher,
      this.subjectsTaught,
      this.teachers,
      this.attendanceRecords});

  factory SubGrade.fromJson(Map<String, dynamic> json) =>
      _$SubGradeFromJson(json);

  Map<String, dynamic> toJson() => _$SubGradeToJson(this);
}
