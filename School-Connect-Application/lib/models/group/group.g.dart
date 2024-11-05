// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      groupId: (json['groupId'] as num?)?.toInt(),
      groupMemberIDs: (json['groupMemberIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      groupName: json['groupName'] as String?,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'groupMemberIDs': instance.groupMemberIDs,
      'groupName': instance.groupName,
    };
