import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/chat/chat.dart';
import 'package:scs/models/baseactor/baseactor.dart';
import 'package:scs/models/groupactor/groupactors.dart';
import 'package:scs/models/learnerparent/learnerparent.dart';

part 'parent.g.dart';

@JsonSerializable()
class Parent extends BaseActor {
  @JsonKey(name: "idNo")
  String? idNo;

  @JsonKey(name: "parentType")
  String? parentType;

  @JsonKey(name: "emailAddress")
  String? emailAddress;

  @JsonKey(name: "phoneNumber")
  int? phoneNumber;

  //Relationships
  @JsonKey(name: "children")
  List<LearnerParent>? children;

  @JsonKey(name: "groupNP")
  List<GroupActors>? groupNP;

  @JsonKey(name: "chats")
  List<Chat>? chats;

  Parent({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.profileImageFile,
    super.role,
    super.title,
    this.idNo,
    this.parentType,
    this.emailAddress,
    this.phoneNumber,
    this.children,
    this.groupNP,
    this.chats,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ParentToJson(this);

  // int get idNo => _idNo;
  // set idNo(int value) {
  //   _idNo = value;
  // }

  // String get parentType => _parentType;
  // set parentType(String value) {
  //   _parentType = value;
  // }

  // String get email => _email;
  // set email(String value) {
  //   _email = value;
  // }

  // List<LearnerParent> get children => _children;
  // set children(List<LearnerParent> value) {
  //   children = value;
  // }

  // List<GroupActors> get groupNP => _groupNP;
  // set groupNP(List<GroupActors> value) {
  //   _groupNP = value;
  // }

  //Convert Parent to a Map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'idNo': idNo,
  //     'parentType': parentType,
  //     'email': email,
  //     'children': children,
  //     'groupNP': groupNP,
  //   };
  // }

  // //Parent Object from a map
  // factory Parent.fromMap(Map<String, dynamic> map) {
  //   return Parent(
  //       id: map['id'],
  //       profileImage: map['profileImage'],
  //       name: map['name'],
  //       surname: map['surname'],
  //       gender: map['gender'],
  //       role: map['role'],
  //       idNo: map['idNo'],
  //       parentType: map['parentType'],
  //       email: map['email'],
  //       children: map['children'],
  //       groupNP: map['groupNP']);
  // }
}
