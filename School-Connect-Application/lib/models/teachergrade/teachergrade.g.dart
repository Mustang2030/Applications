// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachergrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherGrade _$TeacherGradeFromJson(Map<String, dynamic> json) => TeacherGrade(
      teacherID: (json['teacherID'] as num?)?.toInt(),
      staffNr: json['staffNr'] as String?,
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      classId: (json['classId'] as num?)?.toInt(),
      classDesignate: json['classDesignate'] as String?,
      clas: json['class'] == null
          ? null
          : SubGrade.fromJson(json['class'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeacherGradeToJson(TeacherGrade instance) =>
    <String, dynamic>{
      'teacherID': instance.teacherID,
      'staffNr': instance.staffNr,
      'teacher': instance.teacher,
      'classId': instance.classId,
      'classDesignate': instance.classDesignate,
      'class': instance.clas,
    };
