import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/user_model.dart';
import '../domain/models/registration_model.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final String baseUrl = "https://ticketapi.fundspay.in/api/v1/auth";

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    debugPrint("Login API Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint("Parsed Login JSON: $jsonResponse");
      return UserModel.fromJson(jsonResponse);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<RegistrationModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/register");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    debugPrint("Register API Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint("Parsed Register JSON: $jsonResponse");
      return RegistrationModel.fromJson(jsonResponse);
    } else {
      throw Exception("Registration failed: ${response.body}");
    }
  }
}

@riverpod
Future<AuthRepository> authRepository(AuthRepositoryRef ref) async {
  return AuthRepository();
}
