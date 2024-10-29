import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  @JsonKey(name: "groupId")
  int? groupId;

  @JsonKey(name: "groupMemberIDs")
  List<String>? groupMemberIDs;

  @JsonKey(name: "groupName")
  String? groupName;

  Group({
    this.groupId,
    this.groupMemberIDs,
    this.groupName,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  // int get groupId => _groupId;
  // set groupId(int value) {
  //   _groupId = value;
  // }

  // ListBase<Int64> get groupMembersIDs => _groupMembersIDs;
  // set groupMembersIDs(ListBase<Int64> value) {
  //   _groupMembersIDs = value;
  // }

  // String get groupName => _groupName;
  // set groupName(String value) {
  //   _groupName = value;
  // }

  // factory Group.fromMap(Map<String, dynamic> map) {
  //   return Group(
  //       groupId: map['groupId'],
  //       groupMembersIDs: map['groupMembersIDs'],
  //       groupName: map['groupName']);
  // }
}
