// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationModel _$RegistrationModelFromJson(Map<String, dynamic> json) =>
    RegistrationModel(
      token: json['token'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RegistrationModelToJson(RegistrationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
    };
