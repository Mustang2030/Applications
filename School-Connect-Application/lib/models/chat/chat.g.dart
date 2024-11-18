// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: (json['id'] as num?)?.toInt(),
      message: json['message'] as String?,
      timeSent: json['timeSent'] == null
          ? null
          : DateTime.parse(json['timeSent'] as String),
      senderIdentificate: json['senderIdentificate'] as String?,
      receiverIdentificate: json['receiverIdentificate'] as String?,
      subject: json['subject'] as String?,
      teacherId: (json['teacherId'] as num?)?.toInt(),
      parentId: (json['parentId'] as num?)?.toInt(),
      schoolId: (json['schoolId'] as num?)?.toInt(),
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : Parent.fromJson(json['parent'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'timeSent': instance.timeSent?.toIso8601String(),
      'senderIdentificate': instance.senderIdentificate,
      'receiverIdentificate': instance.receiverIdentificate,
      'subject': instance.subject,
      'teacherId': instance.teacherId,
      'parentId': instance.parentId,
      'schoolId': instance.schoolId,
      'teacher': instance.teacher,
      'parent': instance.parent,
      'school': instance.school,
    };
