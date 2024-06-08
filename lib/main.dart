import 'package:authentication_repository/authentication_repository.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:patient_repository/patient_repository.dart';

import 'src/app.dart';
import 'src/blocs/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(
    DoctorSoftDoctorApp(
      authenticationRepository: AuthenticationRepository(),
      medicRepository: MedicRepository(),
      patientRepository: PatientRepository(),
      doctorSecureStorage: DoctorSecureStorage(),
    ),
  );
}
