//done
import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/parent/parent.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "timeSent")
  DateTime? timeSent;

  @JsonKey(name: "senderIdentificate")
  String? senderIdentificate;

  @JsonKey(name: "receiverIdentificate")
  String? receiverIdentificate;

  @JsonKey(name: "subject")
  String? subject;

  // FK
  @JsonKey(name: "teacherId")
  int? teacherId;

  @JsonKey(name: "parentId")
  int? parentId;

  @JsonKey(name: "schoolId")
  int? schoolId;

  // NP
  @JsonKey(name: "teacher")
  Teacher? teacher;

  @JsonKey(name: "parent")
  Parent? parent;

  @JsonKey(name: "school")
  School? school;

  Chat({
    this.id,
    this.message,
    this.timeSent,
    this.senderIdentificate,
    this.receiverIdentificate,
    this.subject,
    this.teacherId,
    this.parentId,
    this.schoolId,
    this.teacher,
    this.parent,
    this.school,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
