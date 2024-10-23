import 'package:json_annotation/json_annotation.dart';

part 'groupactors.g.dart';

@JsonSerializable()
class GroupActors {
  @JsonKey(name: "actorType")
  String actorType;

  GroupActors({required this.actorType});

  factory GroupActors.fromJson(Map<String, dynamic> json) =>
      _$GroupActorsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupActorsToJson(this);

  // String get actorType => _actorType;
  // set actorType(String value) {
  //   _actorType = value;
  // }

  // factory GroupActors.fromMap(Map<String, dynamic> map) {
  //   return GroupActors(actorType: map['actorType']);
  // }

  // toMap() {}
}
