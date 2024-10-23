// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendence _$AttendenceFromJson(Map<String, dynamic> json) => Attendence(
      attendenceId: (json['attendenceId'] as num).toInt(),
      mondayDate: json['mondayDate'] as bool,
      tuesdayDate: json['tuesdayDate'] as bool,
      wednesdayDate: json['wednesdayDate'] as bool,
      thursdayDate: json['thursdayDate'] as bool,
      fridayDate: json['fridayDate'] as bool,
      learnerId: (json['learnerId'] as num).toInt(),
      teacherId: (json['teacherId'] as num).toInt(),
      learnerNP: Learner.fromJson(json['learnerNP'] as Map<String, dynamic>),
      teacherNP: Teacher.fromJson(json['teacherNP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttendenceToJson(Attendence instance) =>
    <String, dynamic>{
      'attendenceId': instance.attendenceId,
      'mondayDate': instance.mondayDate,
      'tuesdayDate': instance.tuesdayDate,
      'wednesdayDate': instance.wednesdayDate,
      'thursdayDate': instance.thursdayDate,
      'fridayDate': instance.fridayDate,
      'learnerId': instance.learnerId,
      'teacherId': instance.teacherId,
      'learnerNP': instance.learnerNP,
      'teacherNP': instance.teacherNP,
    };
