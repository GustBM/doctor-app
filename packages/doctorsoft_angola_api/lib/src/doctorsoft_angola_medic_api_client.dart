import 'dart:async';

import 'package:doctor_soft_angola_api/src/dio/dio_client.dart';
import 'package:doctor_soft_angola_api/src/models/enviroment.dart';
import 'package:medic_repository/medic_repository.dart';

class MedicRequestFailure implements Exception {
  const MedicRequestFailure([
    this.message = 'Houve um erro desconhecido.',
  ]);

  factory MedicRequestFailure.fromCode(int? statusCode) {
    switch (statusCode) {
      case 403:
        return const MedicRequestFailure(
          'Token Inválido.',
        );
      case 404:
        return const MedicRequestFailure(
          'Erro de Envio. Verifique a conexão e tente novamente.',
        );
      case 406:
        return const MedicRequestFailure(
          'Médico não encontrado. Verifique as informações e tente novamente.',
        );
      default:
        return const MedicRequestFailure();
    }
  }

  final String message;
}

class DoctorScheduleRequestFailure implements Exception {
  const DoctorScheduleRequestFailure([
    this.message = 'Houve um erro desconhecido.',
  ]);

  factory DoctorScheduleRequestFailure.fromCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const DoctorScheduleRequestFailure(
          'A diferença de datas não pode ser maior do que 30 dias.',
        );
      case 403:
        return const DoctorScheduleRequestFailure(
          'Token Inválido.',
        );
      case 404:
        return const DoctorScheduleRequestFailure(
          'Verifique a conexão e tente novamente.',
        );
      case 406:
        return const DoctorScheduleRequestFailure(
          'Agenda não encontrada. Verifique as informações e tente novamente.',
        );
      default:
        return const DoctorScheduleRequestFailure();
    }
  }

  final String message;
}

class MedicApiClient {
  MedicApiClient({
    DioClient? dioClient,
  }) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<Medic> getMedic({
    required String medicId,
  }) async {
    final medicResponse =
        await _dioClient.get(endpoint: '${Endpoints.userDoctor}/$medicId');

    if (medicResponse.statusCode != 200) {
      throw MedicRequestFailure.fromCode(medicResponse.statusCode);
    }

    final res =
        Medic.fromJson(medicResponse.data['data'] as Map<String, dynamic>);

    return res;
  }

  Future<List<Schedule>> getDoctorSchedule({
    required String medicId,
    required String dateStart,
    required String dateEnd,
  }) async {
    final scheduleResponse = await _dioClient.get(
      endpoint: '${Endpoints.schedules}/$medicId',
      queryParameters: <String, String>{
        'startDate': dateStart,
        'endDate': dateEnd,
      },
    );

    if (scheduleResponse.statusCode != 200) {
      throw DoctorScheduleRequestFailure.fromCode(
        scheduleResponse.statusCode,
      );
    }

    return (scheduleResponse.data['data'] as List)
        .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
