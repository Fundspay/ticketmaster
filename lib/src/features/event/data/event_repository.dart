// lib/src/features/event/data/event_repository.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/event_model.dart';

part 'event_repository.g.dart';

class EventRepository {
  final String baseUrl = "http://localhost:3000/api/v1/events";

  Future<List<EventModel>> fetchEvents() async {
    final url = Uri.parse("$baseUrl/"); 
    debugPrint("Fetching events from URL: $url");
    
    final response = await http.get(url);
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Headers: ${response.headers}");
    debugPrint("Raw Response Body: ${response.body}");
    
    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonData = jsonDecode(response.body);
        debugPrint("Decoded JSON: $jsonData");
        final events = jsonData.map((json) => EventModel.fromJson(json)).toList();
        debugPrint("Parsed ${events.length} events successfully.");
        return events;
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        throw Exception("Failed to decode events response: $e");
      }
    } else {
      debugPrint("Error: Failed to load events. Response: ${response.body}");
      throw Exception("Failed to load events: ${response.body}");
    }
  }
}

@riverpod
Future<EventRepository> eventRepository(EventRepositoryRef ref) async {
  return EventRepository();
}
