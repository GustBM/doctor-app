import 'dart:ui' as ui;

import 'package:intl/intl.dart';
import 'package:doctor247_doutor/src/ui/patient/patient_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:patient_repository/patient_repository.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});

  final Patient patient;

  IconData scheduleTagCardIcon(ConsultationType consultationType) {
    switch (consultationType) {
      case ConsultationType.videoConsultation:
        return Icons.videocam_outlined;
      case ConsultationType.localConsultation:
        return Icons.people_alt_outlined;
      case ConsultationType.procedure:
        return Icons.medical_services_outlined;
      case ConsultationType.exam:
        return Icons.personal_injury_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MedicalRecordScreen.route(patient)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
        child: Card(
          margin: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xff3BB2B8), width: 4.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ClipOval(
                      child: Material(
                        shape: CircleBorder(
                            side: BorderSide(
                                color: Color(0xff3BB2B8), width: 2.0)),
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
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 14,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              dateFormat.format(patient.birthDate),
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontFamily: 'Avenir',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.mail_outline,
                              size: 14,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              patient.email ?? ' - ',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontFamily: 'Avenir',
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  patient.name,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
