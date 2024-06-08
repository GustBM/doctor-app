import 'package:json_annotation/json_annotation.dart';

part 'insurance.g.dart';

@JsonSerializable()
class Insurance {
  Insurance({
    required this.fantasyName,
    required this.registration,
    required this.expiration,
    this.picture,
  });
  factory Insurance.fromJson(Map<String, dynamic> json) =>
      _$InsuranceFromJson(json);

  String fantasyName;
  String registration;
  DateTime expiration;
  String? picture;
}
