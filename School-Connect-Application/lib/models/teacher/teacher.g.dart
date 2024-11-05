// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      title: json['title'] as String?,
      staffNr: json['staffNr'] as String?,
      mainClass: json['mainClass'] == null
          ? null
          : SubGrade.fromJson(json['mainClass'] as Map<String, dynamic>),
      classes: (json['classes'] as List<dynamic>?)
          ?.map((e) => TeacherGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneNumber: (json['phoneNumber'] as num?)?.toInt(),
      emailAddress: json['emailAddress'] as String?,
      schoolID: (json['schoolID'] as num?)?.toInt(),
      announcementNP: (json['announcementNP'] as List<dynamic>?)
          ?.map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupNP: (json['groupNP'] as List<dynamic>?)
          ?.map((e) => GroupActors.fromJson(e as Map<String, dynamic>))
          .toList(),
      teacherSchoolNP: json['teacherSchoolNP'] == null
          ? null
          : School.fromJson(json['teacherSchoolNP'] as Map<String, dynamic>),
    )..attendanceRecords = (json['attendanceRecords'] as List<dynamic>?)
        ?.map((e) => Attendence.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'profileImage': instance.profileImage,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'role': instance.role,
      'staffNr': instance.staffNr,
      'subjects': instance.subjects,
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'schoolID': instance.schoolID,
      'mainClass': instance.mainClass,
      'classes': instance.classes,
      'teacherSchoolNP': instance.teacherSchoolNP,
      'groupNP': instance.groupNP,
      'announcementNP': instance.announcementNP,
      'attendanceRecords': instance.attendanceRecords,
    };
