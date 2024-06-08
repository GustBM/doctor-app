import 'package:authentication_repository/authentication_repository.dart';
import 'package:doctor247_doutor/src/ui/account/account_change_password_screen.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:patient_repository/patient_repository.dart';

import '../theme/theme_data.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/newPassword/new_password_bloc.dart';
import 'blocs/patient/patient_bloc.dart';
import 'blocs/schedule/schedule_bloc.dart';
import 'ui/account/account_screen.dart';
import 'ui/main_screen.dart';
import 'ui/splash_screen.dart';

class DoctorSoftDoctorApp extends StatelessWidget {
  const DoctorSoftDoctorApp({
    super.key,
    required this.doctorSecureStorage,
    required this.authenticationRepository,
    required this.medicRepository,
    required this.patientRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final MedicRepository medicRepository;
  final PatientRepository patientRepository;
  final DoctorSecureStorage doctorSecureStorage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            medicRepository: medicRepository,
            doctorSecureStorage: doctorSecureStorage,
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (_) => NewPasswordBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (_) => PatientBloc(
            medicRepository: medicRepository,
            patientRepository: patientRepository,
            doctorSecureStorage: doctorSecureStorage,
          ),
        ),
        BlocProvider(
          create: (_) => ScheduleBloc(
            medicRepository: medicRepository,
          ),
        )
      ],
      child: const DoctorSoftDoctorAppView(),
    );
  }
}

class DoctorSoftDoctorAppView extends StatefulWidget {
  const DoctorSoftDoctorAppView({super.key});

  @override
  State<DoctorSoftDoctorAppView> createState() => _DoctorSoftDoctorAppView();
}

class _DoctorSoftDoctorAppView extends State<DoctorSoftDoctorAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoctorSoft247-Doutor',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: appThemeData,
      darkTheme: appDarkThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                if (state.user.updatePassword) {
                  _navigator!.pushAndRemoveUntil<void>(
                    AccountChangePasswordScreen.route(),
                    (route) => false,
                  );
                } else {
                  _navigator!.pushAndRemoveUntil<void>(
                    MainScreen.route(state.user, state.medic),
                    (route) => false,
                  );
                }
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  AccountScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
              case AuthenticationStatus.appStart:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
