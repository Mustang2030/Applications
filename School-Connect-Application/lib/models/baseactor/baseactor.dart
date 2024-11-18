import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'baseactor.g.dart';

@JsonSerializable()
class BaseActor {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "profileImage")
  String? profileImage;

  @JsonKey(name: "profileImageBase64")
  String? profileImageBase64;

  @JsonKey(name: "profileImageType")
  String? profileImageType;

  @JsonKey(
      name: "profileImageFile", includeToJson: false, includeFromJson: false)
  MultipartFile? profileImageFile;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "surname")
  String? surname;

  @JsonKey(name: "gender")
  String? gender;

  @JsonKey(name: "role")
  String? role;

  // Constructor with optional parameters
  BaseActor({
    this.id,
    this.profileImage,
    this.name,
    this.surname,
    this.gender,
    this.role,
    this.title,
    this.profileImageFile,
    this.profileImageBase64,
    this.profileImageType,
  });

  factory BaseActor.fromJson(Map<String, dynamic> json) =>
      _$BaseActorFromJson(json);

  Map<String, dynamic> toJson() {
    final data = _$BaseActorToJson(this);

    // Exclude the MultipartFile from the normal Json serialization
    // data.remove('profileImageFile');

    return data;
  }

  //       profileImage: json['profileImage'],
  //       name: json['name'],
  //       surname: json["surname"],
  //       gender: json['gender'],
  //       role: json['role'],
  //     );

  // // Convert a BaseActor object to a JSON-like Map
  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'profileImage': profileImage,
  //       'name': name,
  //       'surname': surname,
  //       'gender': gender,
  //       'role': role,
  //     };
}
