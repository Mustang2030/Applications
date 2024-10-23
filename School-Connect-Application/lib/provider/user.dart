import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/baseactor/baseactor.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseActor {
  @JsonKey(name: "emailAddress")
  String? emailAddress;

  @JsonKey(name: "phoneNumber")
  int? phoneNumber;

  User({
    super.id,
    super.profileImage,
    super.name,
    super.surname,
    super.gender,
    super.role,
    this.emailAddress,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
