import 'package:flutter/material.dart';

class DoctorAppointmentCard extends StatelessWidget {
  const DoctorAppointmentCard(
      {Key? key, required this.title, required this.local, required this.date})
      : super(key: key);

  final String title;
  final String local;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1),
        ),
        color: const Color(0xFF02959B),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: Color(0xFF46C1B7),
                    ),
                    Text(local, style: const TextStyle(color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Color(0xFF46C1B7),
                    ),
                    Text(date, style: const TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ));
  }
}
