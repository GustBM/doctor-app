part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class PatientStatusChanged extends PatientEvent {
  const PatientStatusChanged(this.status);

  final PatientStatus status;

  @override
  List<Object> get props => [status];
}

class PatientSearch extends PatientEvent {
  const PatientSearch(this.patientId);

  final String patientId;

  @override
  List<Object> get props => [patientId];
}

class PatientRefresh extends PatientEvent {
  const PatientRefresh();

  @override
  List<Object> get props => [];
}

class PatientRecent extends PatientEvent {
  const PatientRecent(this.patientsId);

  final List<String> patientsId;

  @override
  List<Object> get props => [patientsId];
}
