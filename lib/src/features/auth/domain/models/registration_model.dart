import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final String message;
  final UserData user;

  RegistrationModel({
    required this.message,
    required this.user,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}

@JsonSerializable()
class UserData {
  final String id;
  final String role;
  final String name;
  final String email;
  final String password;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  UserData({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.password,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
