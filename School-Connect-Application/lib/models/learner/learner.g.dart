// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Learner _$LearnerFromJson(Map<String, dynamic> json) => Learner(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      title: json['title'] as String?,
      idNo: json['idNo'] as String?,
      classCode: json['classCode'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      schoolID: (json['schoolID'] as num?)?.toInt(),
      classID: (json['classId'] as num?)?.toInt(),
      learnerSchoolNP: json['learnerSchoolNP'] == null
          ? null
          : School.fromJson(json['learnerSchoolNP'] as Map<String, dynamic>),
      clas: json['class'] == null
          ? null
          : SubGrade.fromJson(json['class'] as Map<String, dynamic>),
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => LearnerParent.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendenceRecords: (json['attendenceRecords'] as List<dynamic>?)
          ?.map((e) => Attendence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LearnerToJson(Learner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'profileImage': instance.profileImage,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'role': instance.role,
      'idNo': instance.idNo,
      'classCode': instance.classCode,
      'subjects': instance.subjects,
      'classId': instance.classID,
      'schoolID': instance.schoolID,
      'learnerSchoolNP': instance.learnerSchoolNP,
      'parents': instance.parents,
      'class': instance.clas,
      'attendenceRecords': instance.attendenceRecords,
    };
