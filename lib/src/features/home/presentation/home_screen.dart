import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/ticket_model.dart';
import '../application/ticket_controller.dart';
import 'package:ticketmaster/src/features/auth/application/auth_controller.dart'; // printing id change here

class TicketListScreen extends ConsumerStatefulWidget {
  const TicketListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends ConsumerState<TicketListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Retrieve user id from registration response in authController
      final authState = ref.read(authControllerProvider);
      final userId = authState.registration?.user.id; // printing id change here
      if (userId != null && userId.isNotEmpty) {
        ref.read(ticketControllerProvider.notifier).loadTickets(userId);
      } else {
        debugPrint("No registered user id available"); // printing id change here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(ticketControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Tickets')),
      body: ticketState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ticketState.error != null
              ? Center(child: Text("Error: ${ticketState.error}"))
              : ticketState.tickets == null || ticketState.tickets!.isEmpty
                  ? const Center(child: Text("No tickets available"))
                  : ListView.builder(
                      itemCount: ticketState.tickets!.length,
                      itemBuilder: (context, index) {
                        final ticket = ticketState.tickets![index];
                        return ListTile(
                          title: Text(
                            ticket.event.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(ticket.event.description),
                          onTap: () {
                            // Optionally show more details
                          },
                        );
                      },
                    ),
    );
  }
}
