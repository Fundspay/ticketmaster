import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/event_model.dart';

part 'event_repository.g.dart';

class EventRepository {
  // Use your actual API endpoint here.
  final String baseUrl = "https://8412-150-129-156-34.ngrok-free.app/api/v1/events";

  Future<List<EventModel>> fetchEvents() async {
    final url = Uri.parse("$baseUrl/");
    debugPrint("Fetching events from URL: $url");
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      debugPrint("Response: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Headers: ${response.headers}");
      debugPrint("Raw Response Body: ${response.body}");
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        debugPrint("Decoded JSON: $jsonData");
        final events = jsonData.map((json) => EventModel.fromJson(json)).toList();
        debugPrint("Parsed ${events.length} events successfully.");
        return events;
      } else {
        debugPrint("Error: Failed to load events. Response: ${response.body}");
        throw Exception("Failed to load events: ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception caught in fetchEvents: $e");
      throw Exception("Exception in fetchEvents: $e");
    }
  }
}

@riverpod
Future<EventRepository> eventRepository(EventRepositoryRef ref) async {
  return EventRepository();
}
