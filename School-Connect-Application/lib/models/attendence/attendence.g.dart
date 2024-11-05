// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendence _$AttendenceFromJson(Map<String, dynamic> json) => Attendence(
      attendenceId: (json['attendenceId'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      status: json['status'] as bool?,
      learnerId: (json['learnerId'] as num?)?.toInt(),
      teacherId: (json['teacherId'] as num?)?.toInt(),
      classId: (json['classId'] as num?)?.toInt(),
      schoolId: (json['schoolId'] as num?)?.toInt(),
      learnerNP: json['learnerNP'] == null
          ? null
          : Learner.fromJson(json['learnerNP'] as Map<String, dynamic>),
      teacherNP: json['teacherNP'] == null
          ? null
          : Teacher.fromJson(json['teacherNP'] as Map<String, dynamic>),
      clas: json['class'] == null
          ? null
          : SubGrade.fromJson(json['class'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttendenceToJson(Attendence instance) =>
    <String, dynamic>{
      'attendenceId': instance.attendenceId,
      'date': instance.date?.toIso8601String(),
      'status': instance.status,
      'learnerId': instance.learnerId,
      'teacherId': instance.teacherId,
      'classId': instance.classId,
      'schoolId': instance.schoolId,
      'teacherNP': instance.teacherNP,
      'learnerNP': instance.learnerNP,
      'class': instance.clas,
      'school': instance.school,
    };
