// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseactor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseActor _$BaseActorFromJson(Map<String, dynamic> json) => BaseActor(
      id: (json['id'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      title: json['title'] as String?,
      profileImageBase64: json['profileImageBase64'] as String?,
      profileImageType: json['profileImageType'] as String?,
    );

Map<String, dynamic> _$BaseActorToJson(BaseActor instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'profileImage': instance.profileImage,
      'profileImageBase64': instance.profileImageBase64,
      'profileImageType': instance.profileImageType,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'role': instance.role,
    };
