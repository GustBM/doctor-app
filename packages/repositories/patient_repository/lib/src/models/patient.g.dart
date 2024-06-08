// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'] as String,
      name: json['nome'] as String,
      email: json['email'] as String?,
      tel: json['cel'] as String?,
      address: json['endereco'] as String?,
      birthDate: DateTime.parse(json['nascimento'] as String),
      gender: json['sexo'] as String?,
      picture: json['foto'] as String?,
      note: json['nota'] as String?,
      cpf: json['cpf'] as String?,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.name,
      'email': instance.email,
      'cel': instance.tel,
      'foto': instance.picture,
      'endereco': instance.address,
      'birthDate': instance.birthDate.toIso8601String(),
      'sexo': instance.gender,
      'nota': instance.note,
      'cpf': instance.cpf,
    };
