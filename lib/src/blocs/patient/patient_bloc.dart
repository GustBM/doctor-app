import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:patient_repository/patient_repository.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc({
    required PatientRepository patientRepository,
    required MedicRepository medicRepository,
    required DoctorSecureStorage doctorSecureStorage,
  })  : _patientRepository = patientRepository,
        _medicRepository = medicRepository,
        _doctorSecureStorage = doctorSecureStorage,
        super(PatientLoading()) {
    on<PatientRefresh>(_onPatientRefresh);
    on<PatientRecent>(_onPatientRecent);
  }

  final PatientRepository _patientRepository;
  final MedicRepository _medicRepository;
  final DoctorSecureStorage _doctorSecureStorage;

  @override
  Future<void> close() {
    _patientRepository.dispose();
    _medicRepository.dispose();
    return super.close();
  }

  Future<void> _onPatientRefresh(
    PatientRefresh event,
    Emitter<PatientState> emit,
  ) async {
    List<Patient>? patients;
    emit(PatientLoading());
    try {
      patients = await _fetchPatientList();
    } catch (e) {
      emit(PatientFailure(e.toString()));
      return;
    }

    emit(PatientsLoaded(patients: patients ??= []));
  }

  Future<void> _onPatientRecent(
    PatientRecent event,
    Emitter<PatientState> emit,
  ) async {
    List<Patient>? patients;
    emit(PatientLoading());

    try {
      var patientsIds = await _doctorSecureStorage.getPatientsOnHistoric;
      patients = await _fetchFilteredPatientList(patientsIds);
    } catch (e) {
      emit(PatientFailure(e.toString()));
      return;
    }
    emit(PatientsLoaded(patients: patients ??= []));
  }

  Future<List<Patient>?> _fetchFilteredPatientList(
      List<String> patientsId) async {
    if (patientsId == []) return [];

    try {
      List<Patient>? filteredPatients = [];

      final medic = _medicRepository.getSetMedic;

      if (medic == null) return null;

      final patients = await _patientRepository.getPatientList(
        medic.id,
      );

      if (patients == null) return [];

      for (var patient in patients) {
        if (patientsId.contains(patient.id)) {
          filteredPatients.add(patient);
        }
      }

      return filteredPatients;
    } catch (_) {
      return null;
    }
  }

  Future<List<Patient>?> _fetchPatientList() async {
    try {
      final medic = _medicRepository.getSetMedic;

      if (medic == null) return null;

      final patients = await _patientRepository.getPatientList(
        medic.id,
      );
      return patients;
    } catch (_) {
      return null;
    }
  }
}
