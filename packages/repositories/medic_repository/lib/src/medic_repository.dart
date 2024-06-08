import 'dart:async';

import 'package:doctor_soft_angola_api/doctorsoft_angola_api.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:medic_repository/src/models/models.dart';

enum MedicStatus { success, unknown, failure }

enum ScheduleStatus { success, unknown, failure }

class MedicRepository {
  MedicRepository({MedicApiClient? medicApiClient})
      : _medicApiClient = medicApiClient ?? MedicApiClient();

  final MedicApiClient _medicApiClient;
  final _controller = StreamController<MedicStatus>();
  final _schController = StreamController<ScheduleStatus>();
  Medic? _medic;

  Medic? get getSetMedic => _medic;

  Future<Medic?> _setMedic(String medicId) async {
    try {
      _medic = await _medicApiClient.getMedic(medicId: medicId);
      _controller.add(MedicStatus.success);
    } catch (e) {
      _controller.add(MedicStatus.failure);
    }

    return _medic;
  }

  Future<Medic?> getMedic(String medicId) async =>
      _medic ??= await _setMedic(medicId);

  Future<List<Schedule>?> getSchedule({
    required String dateStart,
    required String dateEnd,
  }) async {
    if (_medic == null) return null;

    List<Schedule>? schList;

    try {
      schList = await _medicApiClient.getDoctorSchedule(
        medicId: _medic!.medicId,
        dateStart: dateStart,
        dateEnd: dateEnd,
      );
      _schController.add(ScheduleStatus.success);
    } on DoctorScheduleRequestFailure catch (err) {
      _schController.add(ScheduleStatus.failure);
      // ignore: only_throw_errors
      throw err.message;
    }

    return schList;
  }

  void dispose() {
    _controller.close();
    _schController.close();
  }
}
