// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systemadmin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemAdmin _$SystemAdminFromJson(Map<String, dynamic> json) => SystemAdmin(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      title: json['title'] as String?,
      role: json['role'] as String?,
      staffNr: json['staffNr'] as String?,
      phoneNumber: (json['phoneNumber'] as num?)?.toInt(),
      emailAddress: json['emailAddress'] as String?,
      sysAdminSchoolNP: json['sysAdminSchoolNP'] == null
          ? null
          : School.fromJson(json['sysAdminSchoolNP'] as Map<String, dynamic>),
    )
      ..profileImageBase64 = json['profileImageBase64'] as String?
      ..profileImageType = json['profileImageType'] as String?;

Map<String, dynamic> _$SystemAdminToJson(SystemAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'profileImage': instance.profileImage,
      'profileImageBase64': instance.profileImageBase64,
      'profileImageType': instance.profileImageType,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'role': instance.role,
      'staffNr': instance.staffNr,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'sysAdminSchoolNP': instance.sysAdminSchoolNP,
    };
