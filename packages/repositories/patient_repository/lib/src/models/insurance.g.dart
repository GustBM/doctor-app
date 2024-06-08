// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Insurance _$InsuranceFromJson(Map<String, dynamic> json) => Insurance(
      fantasyName: json['fantasyName'] as String,
      registration: json['registration'] as String,
      expiration: DateTime.parse(json['expiration'] as String),
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$InsuranceToJson(Insurance instance) => <String, dynamic>{
      'fantasyName': instance.fantasyName,
      'registration': instance.registration,
      'expiration': instance.expiration.toIso8601String(),
      'picture': instance.picture,
    };
