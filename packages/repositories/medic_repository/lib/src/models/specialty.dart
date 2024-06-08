import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specialty.g.dart';

@JsonSerializable()
class Specialty extends Equatable {
  const Specialty({
    required this.id,
    required this.name,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyToJson(this);

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
