// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:async';

import 'package:doctor_soft_angola_api/doctorsoft_angola_api.dart';
import 'package:patient_repository/src/models/patient.dart';

enum PatientStatus { success, unknown, failure }

class PatientRepository {
  PatientRepository({PatientApiClient? patientApiClient})
      : _patientApiClient = patientApiClient ?? PatientApiClient();

  final PatientApiClient _patientApiClient;
  final _controller = StreamController<PatientStatus>();

  Stream<PatientStatus> get status async* {
    yield PatientStatus.unknown;
    yield* _controller.stream;
  }

  Future<List<Patient>?> getPatientList(
    String medicId,
  ) async {
    List<Patient>? patientResp;
    try {
      patientResp = await _patientApiClient.getDoctorPatientList(
        medicId,
      );

      _controller.add(PatientStatus.success);
    } on PatientRequestFailure catch (err) {
      _controller.add(PatientStatus.failure);
      // ignore: only_throw_errors
      throw err.message;
    }

    return patientResp;
  }

  void dispose() => _controller.close();
}
