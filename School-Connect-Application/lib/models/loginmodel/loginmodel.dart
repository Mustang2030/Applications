//done
import 'package:json_annotation/json_annotation.dart';

part 'loginmodel.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: "emailAddress")
  String emailAddress;

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "newPassword")
  String newPassword;

  @JsonKey(name: "confirmPassword")
  String confirmPassword;

  LoginModel({
    required this.emailAddress,
    required this.password,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory LoginModel.fromMap(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
