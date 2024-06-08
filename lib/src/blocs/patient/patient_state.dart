part of 'patient_bloc.dart';

@immutable
abstract class PatientState {}

class PatientLoading extends PatientState {}

class PatientInfoLoading extends PatientState {}

class PatientsLoaded extends PatientState {
  PatientsLoaded({
    this.patients = const [],
  });

  final List<Patient> patients;
}

class PatientFailure extends PatientState {
  PatientFailure([this.message = 'Houve um erro ao buscar pacientes.']);

  final String message;
}
