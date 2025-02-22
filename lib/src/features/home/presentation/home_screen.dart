// lib/src/features/home/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dummy ticket model for demonstration
class Ticket {
  final String id;
  final String eventName;
  final String eventDate;
  
  Ticket({required this.id, required this.eventName, required this.eventDate});
}

// Dummy data list
final List<Ticket> tickets = [
  Ticket(id: '1', eventName: 'Movie A', eventDate: '7:50 PM'),
  Ticket(id: '2', eventName: 'Movie B', eventDate: '8:00 PM'),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Your Tickets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return ListTile(
                  title: Text(ticket.eventName),
                  subtitle: Text('Time: ${ticket.eventDate}'),
                  onTap: () {
                    // Show ticket details in a bottom sheet
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildTicketDetailBottomSheet(ticket),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketDetailBottomSheet(Ticket ticket) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ticket ID: ${ticket.id}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Event: ${ticket.eventName}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Time: ${ticket.eventDate}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
