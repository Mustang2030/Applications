// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      id: (json['id'] as num?)?.toInt(),
      classDesignate: json['classDesignate'] as String?,
      schoolId: (json['schoolId'] as num?)?.toInt(),
      gradeScholNP: json['gradeScholNP'] == null
          ? null
          : School.fromJson(json['gradeScholNP'] as Map<String, dynamic>),
      classes: (json['class'] as List<dynamic>?)
          ?.map((e) => SubGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'id': instance.id,
      'classDesignate': instance.classDesignate,
      'schoolId': instance.schoolId,
      'gradeScholNP': instance.gradeScholNP,
      'class': instance.classes,
    };
