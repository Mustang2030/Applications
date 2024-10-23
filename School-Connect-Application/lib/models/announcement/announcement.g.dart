// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      announcementId: (json['announcementId'] as num?)?.toInt(),
      title: json['title'] as String?,
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      content: json['content'] as String?,
      sendEmail: json['sendEmail'] as bool?,
      sendSMS: json['sendSMS'] as bool?,
      viewedRecipients: (json['viewedRecipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      scheduleForLater: json['scheduleForLater'] as bool?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      timeToPost: json['timeToPost'] == null
          ? null
          : DateTime.parse(json['timeToPost'] as String),
      principalID: (json['principalID'] as num?)?.toInt(),
      schoolID: (json['schoolID'] as num?)?.toInt(),
      teacherID: (json['teacherID'] as num?)?.toInt(),
      principalAnnouncementNP: json['principalAnnouncementNP'] == null
          ? null
          : Principal.fromJson(
              json['principalAnnouncementNP'] as Map<String, dynamic>),
      teacherAnnouncementNP: json['teacherAnnouncementNP'] == null
          ? null
          : Teacher.fromJson(
              json['teacherAnnouncementNP'] as Map<String, dynamic>),
      announcementSchoolNP: json['announcementSchoolNP'] == null
          ? null
          : School.fromJson(
              json['announcementSchoolNP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'announcementId': instance.announcementId,
      'title': instance.title,
      'recipients': instance.recipients,
      'content': instance.content,
      'sendEmail': instance.sendEmail,
      'sendSMS': instance.sendSMS,
      'viewedRecipients': instance.viewedRecipients,
      'scheduleForLater': instance.scheduleForLater,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'timeToPost': instance.timeToPost?.toIso8601String(),
      'teacherID': instance.teacherID,
      'principalID': instance.principalID,
      'schoolID': instance.schoolID,
      'principalAnnouncementNP': instance.principalAnnouncementNP,
      'teacherAnnouncementNP': instance.teacherAnnouncementNP,
      'announcementSchoolNP': instance.announcementSchoolNP,
    };
