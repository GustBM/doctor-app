import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medic_repository/src/models/models.dart';

part 'medic.g.dart';

@JsonSerializable()
class Medic extends Equatable {
  const Medic({
    required this.uid,
    required this.medicId,
    required this.tel,
    required this.adress,
    required this.mediumTime,
    required this.specialty,
    required this.name,
    required this.crm,
    required this.emEmergency,
    this.picture,
  });

  factory Medic.fromJson(Map<String, dynamic> json) => _$MedicFromJson(json);

  Map<String, dynamic> toJson() => _$MedicToJson(this);

  String get getFirstName => name.split(' ').first;

  final String uid;
  final String medicId;
  final String crm;
  final String name;
  final String tel;
  final String adress;
  final bool emEmergency;
  final int mediumTime;
  final String? picture;
  final List<Specialty> specialty;

  static const empty = Medic(
    uid: '',
    medicId: '',
    tel: '',
    adress: '',
    mediumTime: 0,
    specialty: [],
    name: '',
    crm: '',
    emEmergency: false,
  );

  @override
  List<Object> get props => [uid, name, crm];
}
