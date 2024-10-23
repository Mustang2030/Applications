import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/school/school.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  // Fields
  @JsonKey(name: "addressID")
  int? addressID = 0;

  @JsonKey(name: "street")
  String? street;

  @JsonKey(name: "suburb")
  String? suburb;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "postalCode")
  String? postalCode;

  @JsonKey(name: "province")
  String? province;

  @JsonKey(name: "schoolID")
  int? schoolID;

  @JsonKey(name: "school")
  School? school;

  // Constructorthis.
  Address({
    this.addressID,
    this.street,
    this.suburb,
    this.city,
    this.postalCode,
    this.province,
    this.schoolID,
    this.school,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  // Getters and Setters
  // String get addressId => _addressId;
  // set addressId(String value) {
  //   _addressId = value;
  // }

  // String get street => _street;
  // set street(String value) {
  //   _street = value;
  // }

  // String get suburb => _suburb;
  // set suburb(String value) {
  //   _suburb = value;
  // }

  // String get city => _city;
  // set city(String value) {
  //   _city = value;
  // }

  // int get postalCode => _postalCode;
  // set postalCode(int value) {
  //   _postalCode = value;
  // }

  // String get province => _province;
  // set province(String value) {
  //   _province = value;
  // }

  // Convert Address to a Map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'addressId': _addressId,
  //     'street': _street,
  //     'suburb': _suburb,
  //     'city': _city,
  //     'postalCode': _postalCode,
  //     'province': _province,
  //   };
  // }

  // // Create Address object from a Map
  // factory Address.fromMap(Map<String, dynamic> map) {
  //   return Address(
  //     addressId: map['addressId'],
  //     street: map['street'],
  //     suburb: map['suburb'],
  //     city: map['city'],
  //     postalCode: map['postalCode'],
  //     province: map['province'],
  //   );
  // }
}
