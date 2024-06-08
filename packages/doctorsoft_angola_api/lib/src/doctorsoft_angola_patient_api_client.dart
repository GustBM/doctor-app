import 'dart:async';

import 'package:doctor_soft_angola_api/src/dio/dio_client.dart';
import 'package:doctor_soft_angola_api/src/models/models.dart';
import 'package:patient_repository/patient_repository.dart';

class PatientRequestFailure implements Exception {
  const PatientRequestFailure([
    this.message = 'Houve um erro desconhecido.',
  ]);

  factory PatientRequestFailure.fromCode(int? statusCode) {
    switch (statusCode) {
      case 403:
        return const PatientRequestFailure(
          'Token Inválido.',
        );
      case 404:
        return const PatientRequestFailure(
          'Erro de Envio. Verifique a conexão e tente novamente.',
        );
      case 406:
        return const PatientRequestFailure(
          'Médico não possui pacientes',
        );
      default:
        return const PatientRequestFailure();
    }
  }

  final String message;
}

class PatientNotFoundFailure implements Exception {}

class PatientApiClient {
  PatientApiClient({
    DioClient? dioClient,
  }) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<List<Patient>> getDoctorPatientList(
    String medicId,
  ) async {
    final patientResponse = await _dioClient.get(
      endpoint: '${Endpoints.patientList}/$medicId',
    );

    if (patientResponse.statusCode != 200) {
      throw PatientRequestFailure.fromCode(patientResponse.statusCode);
    }

    return (patientResponse.data['data'] as List)
        .map((e) => Patient.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
