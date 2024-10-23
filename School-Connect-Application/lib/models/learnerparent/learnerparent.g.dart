// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learnerparent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnerParent _$LearnerParentFromJson(Map<String, dynamic> json) =>
    LearnerParent(
      learnerId: (json['learnerId'] as num?)?.toInt(),
      learner: json['learner'] == null
          ? null
          : Learner.fromJson(json['learner'] as Map<String, dynamic>),
      learnerIdNo: json['learnerIdNo'] as String?,
      parentId: (json['parentId'] as num?)?.toInt(),
      parentIdNo: json['parentIdNo'] as String?,
      parent: json['parent'] == null
          ? null
          : Parent.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LearnerParentToJson(LearnerParent instance) =>
    <String, dynamic>{
      'learnerId': instance.learnerId,
      'learnerIdNo': instance.learnerIdNo,
      'learner': instance.learner,
      'parentId': instance.parentId,
      'parentIdNo': instance.parentIdNo,
      'parent': instance.parent,
    };
