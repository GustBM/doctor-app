// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medic _$MedicFromJson(Map<String, dynamic> json) => Medic(
      uid: json['user_id'] as String,
      medicId: json['medico_id'] as String,
      tel: json['cel'] as String,
      adress: json['endereco'] as String,
      mediumTime: json['tempo_medio'] as int,
      specialty: (json['especialidade'] as List<dynamic>)
          .map((e) => Specialty.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['nome'] as String,
      crm: json['crm'] as String,
      emEmergency: json['em_emergencia'] as bool,
      picture: json['foto'] as String?,
    );

Map<String, dynamic> _$MedicToJson(Medic instance) => <String, dynamic>{
      'user_id': instance.uid,
      'medico_id': instance.medicId,
      'crm': instance.crm,
      'nome': instance.name,
      'cel': instance.tel,
      'endereco': instance.adress,
      'em_emergencia': instance.emEmergency,
      'tempo_medio': instance.mediumTime,
      'foto': instance.picture,
      'especializacao': instance.specialty,
    };
