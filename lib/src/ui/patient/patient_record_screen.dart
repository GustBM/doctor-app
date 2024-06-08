import 'package:doctor247_doutor/src/ui/widgets/grid_menu/grid_menu.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:flutter/material.dart';
import 'package:patient_repository/patient_repository.dart';

import 'patient_doc_list.dart';
import '../widgets/grid_menu/grid_menu_square.dart';
import '../widgets/image_circle_avatar.dart';

class MedicalRecordScreen extends StatelessWidget {
  MedicalRecordScreen({Key? key, required this.patient}) : super(key: key);

  final Patient patient;
  final UserHistoric userHistoric = UserHistoric();

  static Route<void> route(Patient patient) {
    return MaterialPageRoute<void>(
        builder: (_) => MedicalRecordScreen(patient: patient));
  }

  @override
  Widget build(BuildContext context) {
    userHistoric.addPatientToHistory(patient.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prontuário"),
      ),
      body: _PatientInfoPage(patient: patient),
    );
  }
}

class _PatientInfoPage extends StatelessWidget {
  const _PatientInfoPage({Key? key, required this.patient}) : super(key: key);

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 32, 8),
                child: ImageCircleAvatar(
                  imageUrl:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-XrVcXH4xTuCYUxtg9HnU3NYIL0915_vXfg&usqp=CAU",
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      patient.name,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(patient.tel ?? ' - ')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(patient.email ?? ' - ')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(thickness: 2),
          GridMenu(
            squares: [
              SquareMenuGrid(
                title: "Anamnese",
                icon: Icons.article_outlined,
                function: () => Navigator.of(context).push(PatientDocList.route(
                    patientDocType: PatientDocType.anamase)),
              ),
              SquareMenuGrid(
                title: "Exames Complementares",
                icon: Icons.content_paste_search,
                function: () => Navigator.of(context).push(
                    PatientDocList.route(patientDocType: PatientDocType.exame)),
              ),
              SquareMenuGrid(
                title: "Diagnósticos",
                icon: Icons.personal_injury_outlined,
                function: () => Navigator.of(context).push(PatientDocList.route(
                    patientDocType: PatientDocType.diagnostico)),
              ),
              SquareMenuGrid(
                title: "Atestado",
                icon: Icons.assignment_outlined,
                function: () => Navigator.of(context).push(PatientDocList.route(
                    patientDocType: PatientDocType.atestados)),
              ),
              SquareMenuGrid(
                title: "Receituário",
                icon: Icons.medical_services_outlined,
                function: () => Navigator.of(context).push(PatientDocList.route(
                    patientDocType: PatientDocType.receituario)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
