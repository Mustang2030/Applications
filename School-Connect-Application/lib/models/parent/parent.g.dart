// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parent _$ParentFromJson(Map<String, dynamic> json) => Parent(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      title: json['title'] as String?,
      idNo: json['idNo'] as String?,
      parentType: json['parentType'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: (json['phoneNumber'] as num?)?.toInt(),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => LearnerParent.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupNP: (json['groupNP'] as List<dynamic>?)
          ?.map((e) => GroupActors.fromJson(e as Map<String, dynamic>))
          .toList(),
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..profileImageBase64 = json['profileImageBase64'] as String?
      ..profileImageType = json['profileImageType'] as String?;

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'profileImage': instance.profileImage,
      'profileImageBase64': instance.profileImageBase64,
      'profileImageType': instance.profileImageType,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'role': instance.role,
      'idNo': instance.idNo,
      'parentType': instance.parentType,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'children': instance.children,
      'groupNP': instance.groupNP,
      'chats': instance.chats,
    };
