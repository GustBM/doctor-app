import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'home/home_screen.dart';
import 'home/schedule_calendar_screen.dart';
import 'patient/patient_list_screen.dart';
import 'profile/doctor_profile_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final Medic medic;
  const MainScreen({Key? key, required this.user, required this.medic})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

  static Route<void> route(User user, Medic medic) {
    return MaterialPageRoute<void>(
        builder: (_) => MainScreen(
              user: user,
              medic: medic,
            ));
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  Widget _returnScreen(User user, Medic medic, int index) {
    switch (index) {
      case 0:
        return const PatientListScreen();
      case 1:
        return HomeScreen(
          medic: medic,
          redirectFunction: _goToPatients,
        );
      case 2:
        return const ScheduleCalendarScreen();
      case 3:
        return DoctorProfileScreen(medic: medic);
      default:
        break;
    }
    return const SizedBox();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _goToPatients() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _returnScreen(widget.user, widget.medic, _currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.white,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color.fromARGB(255, 170, 164, 164),
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.folder_copy_outlined), label: 'Pacientes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Início'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Agenda'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_circle_outlined), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
