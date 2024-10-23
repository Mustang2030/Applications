import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/learner/learner.dart';
import 'package:scs/models/parent/parent.dart';

part 'learnerparent.g.dart';

@JsonSerializable()
class LearnerParent {
  @JsonKey(name: "learnerId")
  int? learnerId;

  @JsonKey(name: "learnerIdNo")
  String? learnerIdNo;

  @JsonKey(name: "learner")
  Learner? learner;

  @JsonKey(name: "parentId")
  int? parentId;

  @JsonKey(name: "parentIdNo")
  String? parentIdNo;

  @JsonKey(name: "parent")
  Parent? parent;

  LearnerParent({
    this.learnerId,
    this.learner,
    this.learnerIdNo,
    this.parentId,
    this.parentIdNo,
    this.parent,
  });

  factory LearnerParent.fromJson(Map<String, dynamic> json) =>
      _$LearnerParentFromJson(json);

  Map<String, dynamic> toJson() => _$LearnerParentToJson(this);

  // int get learnerId => _learnerId;
  // set learnerId(int value) {
  //   _learnerId = value;
  // }

  // Learner get learner => _learner;
  // set learner(Learner value) {
  //   learner = value;
  // }

  // int get parentId => _parentId;
  // set parentId(int value) {
  //   _parentId = value;
  // }

  // Parent get parent => _parent;
  // set parent(Parent value) {
  //   _parent = value;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'learnerId': learnerId,
  //     'learner': learner,
  //     'parentId': parentId,
  //     'parent': parent,
  //   };
  // }

  // factory LearnerParent.fromMap(Map<String, dynamic> map) {
  //   return LearnerParent(
  //       learnerId: map['learnerId'],
  //       learner: map['learner'],
  //       parentId: map['parentId'],
  //       parent: map['parent']);
  // }
}
