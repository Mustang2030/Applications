// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Principal _$PrincipalFromJson(Map<String, dynamic> json) => Principal(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      title: json['title'] as String?,
      role: json['role'] as String?,
      staffNr: json['staffNr'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: (json['phoneNumber'] as num?)?.toInt(),
      schoolID: (json['schoolID'] as num?)?.toInt(),
      principalSchoolNP: json['principalSchoolNP'] == null
          ? null
          : School.fromJson(json['principalSchoolNP'] as Map<String, dynamic>),
      announcementsNP: json['announcementsNP'] == null
          ? null
          : Announcement.fromJson(
              json['announcementsNP'] as Map<String, dynamic>),
    )
      ..profileImageBase64 = json['profileImageBase64'] as String?
      ..profileImageType = json['profileImageType'] as String?;

Map<String, dynamic> _$PrincipalToJson(Principal instance) => <String, dynamic>{
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
      'schoolID': instance.schoolID,
      'principalSchoolNP': instance.principalSchoolNP,
      'announcementsNP': instance.announcementsNP,
    };
