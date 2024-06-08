import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';

import '../patient/patient_record_screen.dart';
import '../widgets/image_circle_avatar.dart';

class AppointmentInformationScreen extends StatelessWidget {
  const AppointmentInformationScreen({Key? key, required this.consultation})
      : super(key: key);
  final Schedule consultation;

  String get scheduleDateFormat =>
      '${consultation.dataAgendada.substring(8, 10)}/${consultation.dataAgendada.substring(5, 7)}/${consultation.dataAgendada.substring(0, 4)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        consultation.paciente.name,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(consultation.paciente.tel ?? ' - ')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(consultation.paciente.email ?? ' - ')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MedicalRecordScreen.route(consultation.paciente));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.newspaper_outlined),
                          Text(" Prontuário"),
                        ],
                      )),
                ),
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.videocam),
                        Text(" Vídeo"),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox.square(dimension: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.calendar_month),
                      Text(
                        scheduleDateFormat,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.access_time_outlined),
                      Text(
                        consultation.horario.substring(0, 5),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.home_repair_service_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      consultation.clinica.address,
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Descrição",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Text(
                  'Lorem ipsum dolor sit amet. Aut suscipit rerum aut harum laudantium aut impedit modi vel natus deleniti et sint officia sit quaerat cupiditate qui facilis inventore. Aut quasi itaque nam voluptatum vero sit enim omnis ut dolores commodi ut perferendis blanditiis.'),
            ),
          ],
        ),
      ),
    );
  }
}
