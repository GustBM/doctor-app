// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      patient: Patient.fromJson(json['paciente'] as Map<String, dynamic>),
      scheduleLocation:
          ScheduleLocation.fromJson(json['clinica'] as Map<String, dynamic>),
      scheduleDate:
          ScheduleDate.fromJson(json['agenda'] as Map<String, dynamic>),
      consultationType: $enumDecodeNullable(
              _$ConsultationTypeEnumMap, json['consultationType']) ??
          ConsultationType.videoConsultation,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'agenda': instance.scheduleDate,
      'clinica': instance.scheduleLocation,
      'paciente': instance.patient,
      'consultationType': _$ConsultationTypeEnumMap[instance.consultationType]!,
    };

const _$ConsultationTypeEnumMap = {
  ConsultationType.videoConsultation: 'videoConsultation',
  ConsultationType.localConsultation: 'localConsultation',
  ConsultationType.procedure: 'procedure',
  ConsultationType.exam: 'exam',
};
