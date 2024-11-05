//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/subgrade/subgrade.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'teachergrade.g.dart';

@JsonSerializable()
class TeacherGrade {
  @JsonKey(name: "teacherID")
  int? teacherID;

  @JsonKey(name: "staffNr")
  String? staffNr;

  //Foreign Key
  @JsonKey(name: "teacher")
  Teacher? teacher;

  @JsonKey(name: "classId")
  int? classId;

  //Navigation Properties
  @JsonKey(name: "classDesignate")
  String? classDesignate;

  @JsonKey(name: "class")
  SubGrade? clas;

  TeacherGrade({
    this.teacherID,
    this.staffNr,
    this.teacher,
    this.classId,
    this.classDesignate,
    this.clas,
  });

  factory TeacherGrade.fromJson(Map<String, dynamic> json) =>
      _$TeacherGradeFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherGradeToJson(this);
}
