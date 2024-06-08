import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
    this.uid,
    this.email,
    this.status,
    this.token,
    this.refreshToken,
    this.accessLevel,
    // ignore: avoid_positional_boolean_parameters
    this.updatePassword,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String uid;
  final String email;
  final String status;
  final String token;
  final String refreshToken;
  final String accessLevel;
  final bool updatePassword;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        uid,
        email,
        status,
        token,
        refreshToken,
        accessLevel,
      ];

  static const empty = User('', '', '', '', '', '', false);
}
