import 'package:doctor247_doutor/theme/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_repository/patient_repository.dart';

import '../../../utils.dart';
import '../../blocs/patient/patient_bloc.dart';
import '../../../theme/light_color.dart';
import '../../../theme/text_styles.dart';
import '../widgets/cards/patient_card.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  void initState() {
    BlocProvider.of<PatientBloc>(context).add(const PatientRefresh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          if (state is PatientsLoaded) {
            return _PatientCardList(patients: state.patients);
          } else if (state is PatientLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PatientFailure) {
            return SnapshotErroMsg(state.message);
          } else {
            return Text('Erro $state');
          }
        },
      ),
    );
  }
}

class _PatientCardList extends StatefulWidget {
  const _PatientCardList({
    required this.patients,
  });

  final List<Patient> patients;

  @override
  State<_PatientCardList> createState() => _PatientCardListState();
}

class _PatientCardListState extends State<_PatientCardList> {
  List<Patient> _filteredPatients = [];

  @override
  void initState() {
    _filteredPatients = widget.patients;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Patient> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.patients;
    } else {
      results = widget.patients
          .where((patient) =>
              patient.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredPatients = results;
    });
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: const Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Buscar Paciente",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: const Icon(Icons.search, color: Color(0xff3BB2B8))
                  .alignCenter),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientBloc = BlocProvider.of<PatientBloc>(context);

    return RefreshIndicator(
      onRefresh: () async {
        patientBloc.add(const PatientRefresh());
      },
      child: Column(
        children: [
          const SizedBox(height: 25),
          _searchField(),
          Flexible(
            child: _filteredPatients.isEmpty
                ? const SnapshotEmptyMsg(
                    msg: 'Nenhum Paciente Encontrado',
                    icon: Icons.personal_injury_outlined,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredPatients.length,
                    itemBuilder: (context, index) {
                      return PatientCard(patient: _filteredPatients[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
