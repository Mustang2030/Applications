// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teach_mk_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeachMkAttendance _$TeachMkAttendanceFromJson(Map<String, dynamic> json) =>
    TeachMkAttendance(
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      attendanceRecords: (json['attendanceRecords'] as List<dynamic>?)
          ?.map((e) => Attendence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeachMkAttendanceToJson(TeachMkAttendance instance) =>
    <String, dynamic>{
      'teacher': instance.teacher,
      'attendanceRecords': instance.attendanceRecords,
    };
