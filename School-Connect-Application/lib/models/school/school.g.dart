// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: (json['id'] as num?)?.toInt(),
      emisNumber: json['emisNumber'] as String?,
      logo: json['logo'] as String?,
      name: json['name'] as String?,
      dateregistered: json['dateRegistered'] == null
          ? DateTime.now()
          : DateTime.parse(json['dateRegistered'] as String),
      type: json['type'] as String?,
      telephoneNumber: (json['telePhoneNumber'] as num?)?.toInt(),
      emailAddress: json['emailAddress'] as String?,
      systemAdminId: (json['systemAdminId'] as num?)?.toInt(),
      schoolAddress: json['schoolAddress'] == null
          ? null
          : Address.fromJson(json['schoolAddress'] as Map<String, dynamic>),
      schoolLearnersNP: (json['schoolLearnersNP'] as List<dynamic>?)
          ?.map((e) => Learner.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolPrincipalNP: json['schoolPrincipalNP'] == null
          ? null
          : Principal.fromJson(
              json['schoolPrincipalNP'] as Map<String, dynamic>),
      schoolTeachersNP: (json['schoolTeachersNP'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolAnnouncementNP: (json['schoolAnnouncementNP'] as List<dynamic>?)
          ?.map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolGroupsNP: (json['schoolGroupsNP'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolSysAdminNP: json['schoolSysAdminNP'] == null
          ? null
          : SystemAdmin.fromJson(
              json['schoolSysAdminNP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'emisNumber': instance.emisNumber,
      'logo': instance.logo,
      'name': instance.name,
      'dateRegistered': instance.dateregistered?.toIso8601String(),
      'type': instance.type,
      'telePhoneNumber': instance.telephoneNumber,
      'emailAddress': instance.emailAddress,
      'systemAdminId': instance.systemAdminId,
      'schoolAddress': instance.schoolAddress,
      'schoolLearnersNP': instance.schoolLearnersNP,
      'schoolTeachersNP': instance.schoolTeachersNP,
      'schoolAnnouncementNP': instance.schoolAnnouncementNP,
      'schoolSysAdminNP': instance.schoolSysAdminNP,
      'schoolGroupsNP': instance.schoolGroupsNP,
      'schoolPrincipalNP': instance.schoolPrincipalNP,
    };
