// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      addressID: (json['addressID'] as num?)?.toInt(),
      street: json['street'] as String?,
      suburb: json['suburb'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      province: json['province'] as String?,
      schoolID: (json['schoolID'] as num?)?.toInt(),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressID': instance.addressID,
      'street': instance.street,
      'suburb': instance.suburb,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'province': instance.province,
      'schoolID': instance.schoolID,
      'school': instance.school,
    };
