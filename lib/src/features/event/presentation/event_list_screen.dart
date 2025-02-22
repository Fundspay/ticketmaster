import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListScreen extends ConsumerStatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends ConsumerState<EventListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event List')),
      body: const Center(
        child: Text(
          'Event List Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
