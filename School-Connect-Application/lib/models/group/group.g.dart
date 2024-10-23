// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      groupId: (json['groupId'] as num).toInt(),
      groupMembersIDs: (json['groupMembersIDs'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      groupName: json['groupName'] as String,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'groupMembersIDs': instance.groupMembersIDs,
      'groupName': instance.groupName,
    };
