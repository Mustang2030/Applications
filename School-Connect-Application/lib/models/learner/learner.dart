import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/attendence/attendence.dart';
import 'package:scs/models/baseactor/baseactor.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/subgrade/subgrade.dart';

part 'learner.g.dart';

@JsonSerializable()
class Learner extends BaseActor {
  @JsonKey(name: "idNo")
  final String? idNo;

  @JsonKey(name: "classCode")
  final String? classCode;

  @JsonKey(name: "subjects")
  final List<String>? subjects;

  @JsonKey(name: "classId")
  final int? classID;

  Learner({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.role,
    super.title,
    this.idNo,
    this.classCode,
    this.subjects,
    this.schoolID,
    this.classID,
    this.learnerSchoolNP,
    this.clas,
    this.parents,
    this.attendenceRecords,
  });

  //Foreign Key
  @JsonKey(name: "schoolID")
  final int? schoolID;

  //Relationships
  @JsonKey(name: "learnerSchoolNP")
  final School? learnerSchoolNP;

  @JsonKey(name: "parents")
  final List<LearnerParent>? parents;

  @JsonKey(name: "class")
  final SubGrade? clas;

  @JsonKey(name: "attendenceRecords")
  final List<Attendence>? attendenceRecords;

  factory Learner.fromJson(Map<String, dynamic> json) =>
      _$LearnerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LearnerToJson(this);
//Getters and setters
  // int get idNo => _idNo;
  // set idNo(int value) {
  //   _idNo = value;
  // }

  // String get classId => _classId;
  // set classId(String value) {
  //   _classId = value;
  // }

  // List<String> get subjects => _subjects;
  // set subjects(List<String> value) {
  //   _subjects = value;
  // }

  // School get learnerSchoolNP => _learnerSchoolNP;
  // set learnerSchoolNP(School value) {
  //   _learnerSchoolNP = value;
  // }

  // List<LearnerParent> get parents => _parents;
  // set parent(List<LearnerParent> value) {
  //   _parents = value;
  // }

  // int get schoolId => _schoolId;
  // set schoolId(int value) {
  //   _schoolId = value;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'profileImage': profileImage,
  //     'name': name,
  //     'surname': surname,
  //     'gender': gender,
  //     'role': role,
  //     'idNo': _idNo,
  //     'classId': _classId,
  //     'subjects': _subjects,
  //     'learnersSchoolNP': _learnerSchoolNP,
  //     'parents': _parents,
  //     'schoolId': _schoolId,
  //   };
  // }

  //Learner Object from a map
  // factory Learner.fromMap(Map<String, dynamic> json) => Learner(
  //     id: json['id'],
  //     profileImage: json['profileImage'],
  //     name: json['name'],
  //     surname: json['surname'],
  //     gender: json['gender'],
  //     role: json['role'],
  //     idNo: json['idNo'],
  //     classId: json['classId'],
  //     subjects: json['subjects'],
  //     learnerSchoolNP: json['learnerSchoolNP'],
  //     parents: json['parents'],
  //     schoolId: json['schoolId']);

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "profileImage": profileImage,
  //       "name": name,
  //       "surname": surname,
  //       "gender": gender,
  //       "role": role,
  //       "idNo": idNo,
  //       "classId": classId,
  //       "subjects": subjects,
  //       "learnerSchoolNP": learnerSchoolNP,
  //       "parents": parents,
  //       "schoolId": schoolId,
  //     };

  // Learner.fromMap(Map<String, dynamic> map)
  //     : id = map['id'],
  //       profileImage = map['profile_image'],
  //       name = map['name'],
  //       surname = map['surname'],
  //       classId = map['class_id'],
  //       subjects = map['subjects'],
  //       role = map['role'],
  //       emisNo = map['emis_no'];
}
