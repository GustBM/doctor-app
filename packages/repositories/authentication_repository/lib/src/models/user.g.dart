// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['userId'] as String,
      json['email'] as String,
      json['status'] as String,
      json['token'] as String,
      json['refreshToken'] as String,
      json['nivel'] as String,
      json['update_password'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.uid,
      'email': instance.email,
      'status': instance.status,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'nivel': instance.accessLevel,
    };
