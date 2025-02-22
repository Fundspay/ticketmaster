import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final String token;
  final String message;

  RegistrationModel({
    required this.token,
    required this.message,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}
