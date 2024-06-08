import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

int getRandomNumber() {
  var rng = Random();
  var code = rng.nextInt(900000) + 100000;
  return code;
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
final DateFormat apiDateFormat = DateFormat("yyyy-MM-dd");

const Widget listDivider = Divider(
  thickness: 1,
  indent: 4,
  endIndent: 4,
);

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String text,
  required Function confirmFunction,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              confirmFunction();
            },
          ),
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Ok"))
      ],
    ),
  );
}

class SnapshotEmptyMsg extends StatelessWidget {
  const SnapshotEmptyMsg({
    super.key,
    required this.msg,
    required this.icon,
  });

  final String msg;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class SnapshotErroMsg extends StatelessWidget {
  final String msg;
  const SnapshotErroMsg(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 60,
          color: Colors.red,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(32, 8, 32, 0),
          child: Text(
            'Houve um erro',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Text(msg),
      ],
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
