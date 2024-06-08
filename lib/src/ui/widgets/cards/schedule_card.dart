import 'package:doctor247_doutor/src/ui/appointment/apointment_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
    required this.consultation,
  }) : super(key: key);

  final Schedule consultation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AppointmentInformationScreen(
                consultation: consultation,
              ),
              fullscreenDialog: true,
            ));
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(18.0, 4.0, 18.0, 4.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff3BB2B8), width: 4.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consultation.patient.name,
                  style:
                      const TextStyle(color: Color(0xff3BB2B8), fontSize: 16),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 14,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${consultation.scheduleDate.getDateFormatedString}  ',
                      style: const TextStyle(
                          color: Color(0xff3BB2B8), fontSize: 16),
                    ),
                    const Icon(
                      Icons.schedule,
                      size: 14,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      consultation.scheduleDate.getHourFormatedString,
                      style: const TextStyle(
                          color: Color(0xff3BB2B8), fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
