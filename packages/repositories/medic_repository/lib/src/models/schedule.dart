import 'package:json_annotation/json_annotation.dart';
// ignore: implementation_imports
import 'package:patient_repository/src/models/patient.dart';

part 'schedule.g.dart';

enum ConsultationType {
  videoConsultation,
  localConsultation,
  procedure,
  exam,
}

@JsonSerializable()
class Schedule {
  Schedule({
    required this.patient,
    required this.scheduleLocation,
    required this.scheduleDate,
    this.consultationType = ConsultationType.videoConsultation,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  String get getConsultationTypeString {
    switch (consultationType) {
      case ConsultationType.videoConsultation:
        return 'Consulta Vídeo';
      case ConsultationType.localConsultation:
        return 'Consulta Presencial';
      case ConsultationType.procedure:
        return 'Procedimento';
      case ConsultationType.exam:
        return 'Exame';
    }
  }

  ScheduleDate scheduleDate;
  ScheduleLocation scheduleLocation;
  Patient patient;
  ConsultationType consultationType;
}

class ScheduleDate {
  ScheduleDate({
    required this.id,
    required this.dataAgendada,
    required this.etiqueta,
    required this.horario,
  });

  factory ScheduleDate.fromJson(Map<String, dynamic> json) => ScheduleDate(
        id: json['id'] as String,
        dataAgendada: json['dataAgendada'] as String,
        etiqueta: json['etiqueta'] as String,
        horario: json['horario'] as String,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['dataAgendada'] = dataAgendada;
    data['etiqueta'] = etiqueta;
    data['horario'] = horario;
    return data;
  }

  String get getDateFormatedString {
    final year = dataAgendada.substring(0, 4);
    final month = dataAgendada.substring(5, 7);
    final day = dataAgendada.substring(8, 10);

    return '$day/$month/$year';
  }

  String get getHourFormatedString => horario.substring(0, 5);

  DateTime get getScheduleDateDateTime => DateTime.parse(dataAgendada);

  String id;
  String dataAgendada;
  String etiqueta;
  String horario;
}

class ScheduleLocation {
  ScheduleLocation({
    required this.id,
    required this.endereco,
    required this.telefone,
  });

  factory ScheduleLocation.fromJson(Map<String, dynamic> json) =>
      ScheduleLocation(
        id: json['id'] as String,
        endereco: json['endereco'] as String,
        telefone: json['telefone'] as String,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['endereco'] = endereco;
    data['telefone'] = telefone;
    return data;
  }

  String id;
  String endereco;
  String telefone;
}
