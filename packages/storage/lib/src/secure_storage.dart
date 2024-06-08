import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DoctorSecureStorage {
  final storage = const FlutterSecureStorage();

  void setTokens({required String token, required String refreshToken}) {
    storage
      ..write(key: 'token', value: token)
      ..write(key: 'refreshToken', value: refreshToken);
    // ignore: avoid_print
    print('Tokens Renovados');
  }

  Future<String?> get getToken async => storage.read(
        key: 'token',
      );

  Future<String?> get getRefreshToken async => storage.read(
        key: 'refreshToken',
      );

  Future<void> addPatientToHistory(String patientId) async {
    final listOfPatients = await storage.read(key: 'listOfPatients');

    if (listOfPatients == null) {
      await storage.write(
          key: 'listOfPatients', value: jsonEncode(listOfPatients),);
    } else {}
  }

  Future<List<String>> get getPatientsOnHistoric async {
    final historic = await storage.read(key: 'listOfPatients');
    final list = jsonDecode(historic!) as List<String>;
    return list;
  }

  Future<void> deleteTokens() => storage.deleteAll();
}
