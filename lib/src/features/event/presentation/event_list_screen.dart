import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ticketmaster/src/features/event/application/event_controller.dart';
import 'package:ticketmaster/src/features/event/domain/models/event_model.dart';
import 'package:ticketmaster/src/features/auth/application/auth_controller.dart';

class EventListScreen extends ConsumerStatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends ConsumerState<EventListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventControllerProvider.notifier).loadEvents();
    });
  }

  void _showEventDetail(EventModel event) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              const SizedBox(height: 16),
              // New button to register for the event
              ElevatedButton(
                onPressed: () => _registerTicket(event),
                child: const Text("Register Ticket"),
              ), // printing id change here: Register Ticket button added
            ],
          ),
        );
      },
    );
  }

  Future<void> _registerTicket(EventModel event) async {
    // Read the current auth state to get the user id from registration
    final authState = ref.read(authControllerProvider);
    final userId = authState.registration?.user.id ?? "";
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No registered user found. Please register first."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final url = Uri.parse("http://localhost:3000/api/v1/tickets/register"); // printing id change here
    debugPrint("Registering ticket for event: ${event.id} with user: $userId"); // printing id change here

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "eventId": event.id,
          "userId": userId,
        }),
      ).timeout(const Duration(seconds: 10));

      debugPrint("Ticket Registration API Response: ${response.body}"); // printing id change here

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Colors.teal,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration failed: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Ticket Registration Exception: $e"); // printing id change here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state and print registration id if available
    final authState = ref.watch(authControllerProvider);
    if (authState.registration != null) {
      debugPrint("Stored User ID from Registration: ${authState.registration!.user.id}"); // printing id change here
    }

    final eventState = ref.watch(eventControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: eventState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : eventState.error != null
              ? Center(child: Text("Error: ${eventState.error}"))
              : eventState.events == null || eventState.events!.isEmpty
                  ? const Center(child: Text("No events available"))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventState.events!.length,
                      itemBuilder: (context, index) {
                        final event = eventState.events![index];
                        return GestureDetector(
                          onTap: () => _showEventDetail(event),
                          child: Container(
                            width: 220,
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${event.date.day}/${event.date.month}/${event.date.year}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
