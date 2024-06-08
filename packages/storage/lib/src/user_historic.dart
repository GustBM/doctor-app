import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserHistoric {
  final storage = const FlutterSecureStorage();

  Future<void> addPatientToHistory(String patientId) async {
    final patientList = await getPatientsOnHistoric;

    if (patientList.contains(patientId)) {
      patientList
        ..remove(patientId)
        ..insert(0, patientId);
    } else {
      patientList.insert(0, patientId);
    }

    await storage.write(
      key: 'listOfPatients',
      value: jsonEncode(patientList),
    );
    print(patientList);
  }

  Future<List<String>> get getPatientsOnHistoric async {
    final historic = await storage.read(key: 'listOfPatients');
    if (historic == null || historic == 'null') return [];
    final list = (jsonDecode(historic) as List<dynamic>).cast<String>();

    return list;
  }

  void clearHistory() => storage.delete(key: 'listOfPatients');
}
