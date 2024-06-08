import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.tel,
    required this.address,
    required this.birthDate,
    required this.gender,
    this.picture,
    this.note,
    this.cpf,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  String id;
  String name;
  String? email;
  String? tel;
  String? picture;
  String? address;
  DateTime birthDate;
  String? gender;
  String? note;
  String? cpf;
}
