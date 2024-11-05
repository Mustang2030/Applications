// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subgrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubGrade _$SubGradeFromJson(Map<String, dynamic> json) => SubGrade(
      id: (json['id'] as num?)?.toInt(),
      classDesignate: json['classDesignate'] as String?,
      mainTeacherId: (json['mainTeacherId'] as num?)?.toInt(),
      gradeId: (json['gradeId'] as num?)?.toInt(),
      grade: json['grade'] == null
          ? null
          : Grade.fromJson(json['grade'] as Map<String, dynamic>),
      learners: (json['learners'] as List<dynamic>?)
          ?.map((e) => Learner.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainTeacher: json['mainTeacher'] == null
          ? null
          : Teacher.fromJson(json['mainTeacher'] as Map<String, dynamic>),
      subjectsTaught: (json['subjectsTaught'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => TeacherGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendanceRecords: (json['attendanceRecords'] as List<dynamic>?)
          ?.map((e) => Attendence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubGradeToJson(SubGrade instance) => <String, dynamic>{
      'id': instance.id,
      'classDesignate': instance.classDesignate,
      'subjectsTaught': instance.subjectsTaught,
      'mainTeacherId': instance.mainTeacherId,
      'gradeId': instance.gradeId,
      'learners': instance.learners,
      'mainTeacher': instance.mainTeacher,
      'teachers': instance.teachers,
      'grade': instance.grade,
      'attendanceRecords': instance.attendanceRecords,
    };
