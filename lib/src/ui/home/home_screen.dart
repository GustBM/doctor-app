// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:patient_repository/patient_repository.dart';

import 'package:doctor247_doutor/src/blocs/patient/patient_bloc.dart';
import 'package:doctor247_doutor/src/blocs/schedule/schedule_bloc.dart';
import 'package:doctor247_doutor/src/ui/patient/patient_record_screen.dart';
import 'package:doctor247_doutor/src/ui/widgets/doctor_drawer_widget.dart';
import 'package:doctor247_doutor/theme/extention.dart';
import 'package:doctor247_doutor/theme/text_styles.dart';

import '../../../utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/buttons/date_range_selection_widget.dart';
import '../widgets/cards/schedule_card.dart';

class HomeScreen extends StatefulWidget {
  final Medic medic;
  final void Function() redirectFunction;
  const HomeScreen(
      {super.key, required this.medic, required this.redirectFunction});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTimeRange? _selectedRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));

  void goTopatients() {
    setState(() => widget.redirectFunction);
  }

  _setDateTimeRange(DateTimeRange? dateTimeRange) {
    setState(() {
      _selectedRange = dateTimeRange;
      BlocProvider.of<ScheduleBloc>(context).add(ScheduleInit(
        iniDate: apiDateFormat.format(_selectedRange!.start),
        endDate: apiDateFormat.format(_selectedRange!.end),
      ));
    });
  }

  _previousWeek() {
    DateTimeRange newRange = DateTimeRange(
      start: _selectedRange!.start.subtract(const Duration(days: 7)),
      end: _selectedRange!.end.subtract(const Duration(days: 7)),
    );
    _setDateTimeRange(newRange);
  }

  _nextWeek() {
    DateTimeRange newRange = DateTimeRange(
      start: _selectedRange!.start.add(const Duration(days: 7)),
      end: _selectedRange!.end.add(const Duration(days: 7)),
    );
    _setDateTimeRange(newRange);
  }

  @override
  void initState() {
    BlocProvider.of<ScheduleBloc>(context).add(ScheduleInit(
      iniDate: apiDateFormat.format(_selectedRange!.start),
      endDate: apiDateFormat.format(_selectedRange!.end),
    ));
    BlocProvider.of<PatientBloc>(context).add(const PatientRefresh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoctorAppBar(medic: widget.medic),
      drawer: const DoctorDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Próximas Consultas",
                    style: TextStyles.title.copyWith(fontSize: 22).bold,
                    textAlign: TextAlign.left,
                  ).vP16,
                  TextButton(
                      onPressed: widget.redirectFunction,
                      child: const Text('Ver Calendário')),
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _previousWeek(),
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Semana Passada',
                    ),
                    DateRangeSelectionWidget(
                      iniData: dateFormat.format(_selectedRange!.start),
                      endData: dateFormat.format(_selectedRange!.end),
                      restorationId: 'selectionWidget',
                      setDateTimeRangeFunction: _setDateTimeRange,
                    ),
                    IconButton(
                      onPressed: () => _nextWeek(),
                      icon: const Icon(Icons.arrow_forward),
                      tooltip: 'Próxima Semana',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                child: BlocBuilder<ScheduleBloc, ScheduleState>(
                  builder: (context, state) {
                    if (state is ScheduleLoaded) {
                      return _ScheduleList(
                        state.schedules,
                      );
                    } else if (state is ScheduleLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ScheduleFailure) {
                      return SnapshotErroMsg(state.message);
                    } else {
                      return const Text('Erro');
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pacientes Recentes",
                    style: TextStyles.title.copyWith(fontSize: 22).bold,
                    textAlign: TextAlign.left,
                  ).vP16,
                  TextButton(
                      onPressed: widget.redirectFunction,
                      child: const Text('Ver Todos')),
                ],
              ),
              BlocBuilder<PatientBloc, PatientState>(
                builder: (context, state) {
                  if (state is PatientsLoaded) {
                    return _LatestPatientList(
                      patients: state.patients,
                      redirectFunction: widget.redirectFunction,
                    );
                  } else if (state is PatientLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PatientFailure) {
                    return SnapshotErroMsg(state.message);
                  } else {
                    return const Text('Erro');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList(this.schedulesList);

  final List<Schedule> schedulesList;

  Widget createList(BuildContext context, List<Schedule> list) {
    List<Widget> result = [];
    if (list.isEmpty) {
      return const SnapshotEmptyMsg(
        msg: 'Não há consultas marcadas neste período.',
        icon: Icons.medical_services_outlined,
      );
    }
    for (var i = 0; i < list.length; i++) {
      result.add(ScheduleCard(
        consultation: list[i],
      ));
    }
    return SingleChildScrollView(child: Column(children: result));
  }

  @override
  Widget build(BuildContext context) {
    return createList(context, schedulesList);
  }
}

class _LatestPatientList extends StatelessWidget {
  final List<Patient> patients;
  final void Function() redirectFunction;

  final UserHistoric userHistoric = UserHistoric();

  _LatestPatientList({
    Key? key,
    required this.patients,
    required this.redirectFunction,
  }) : super(key: key);

  Widget patientIcon(BuildContext context, Patient patient) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () =>
            Navigator.of(context).push(MedicalRecordScreen.route(patient)),
        child: Tooltip(
          message: patient.name,
          preferBelow: false,
          child: const ClipOval(
            child: Material(
              shape: CircleBorder(
                  side: BorderSide(color: Color(0xff3BB2B8), width: 2.0)),
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.white,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Color(0xff3BB2B8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Patient>> _getPatientList() async {
    List<Patient> resp = [];
    final patientList = await userHistoric.getPatientsOnHistoric;
    for (var patient in patients) {
      if (patientList.contains(patient.id)) {
        resp.add(patient);
      }
    }
    return resp;
  }

  List<Widget> _getRecentPatients(
      BuildContext context, List<Patient> patients) {
    List<Widget> list = [];

    for (var patient in patients) {
      list.add(patientIcon(context, patient));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: FutureBuilder<List<Patient>>(
          future: _getPatientList(),
          builder: (context, AsyncSnapshot<List<Patient>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: _getRecentPatients(context, snapshot.data!),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
