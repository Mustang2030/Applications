//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';

part 'grade.g.dart';

@JsonSerializable()
class Grade {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "classDesignate")
  String? classDesignate;

  //Foreign Key
  @JsonKey(name: "schoolId")
  int? schoolId;

  //Navigation Properties
  @JsonKey(name: "gradeScholNP")
  School? gradeScholNP;

  @JsonKey(name: "class")
  List<SubGrade>? classes;

  Grade({
    this.id,
    this.classDesignate,
    this.schoolId,
    this.gradeScholNP,
    this.classes,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);
}
