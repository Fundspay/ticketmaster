import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/ticket_model.dart';

part 'ticket_repository.g.dart';

class TicketRepository {
  // API endpoint that takes a user_id as a query parameter
  final String baseUrl = "http://localhost:3000/api/v1/tickets";

  Future<List<TicketModel>> fetchTickets({required String userId}) async {
    final url = Uri.parse("$baseUrl?user_id=$userId");
    debugPrint("Fetching tickets from URL: $url"); // printing id change here

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      debugPrint("Tickets API Response: ${response.body}"); // printing id change here
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        debugPrint("Decoded JSON: $jsonData"); // printing id change here
        final tickets = jsonData.map((json) => TicketModel.fromJson(json)).toList();
        debugPrint("Parsed ${tickets.length} tickets successfully."); // printing id change here
        return tickets;
      } else {
        debugPrint("Error: Failed to load tickets. Response: ${response.body}"); // printing id change here
        throw Exception("Failed to load tickets: ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception in fetchTickets: $e"); // printing id change here
      throw Exception("Exception in fetchTickets: $e");
    }
  }
}

@riverpod
Future<TicketRepository> ticketRepository(TicketRepositoryRef ref) async {
  return TicketRepository();
}
