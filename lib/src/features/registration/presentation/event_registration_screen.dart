import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventRegistrationScreen extends ConsumerStatefulWidget {
  const EventRegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventRegistrationScreen> createState() => _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends ConsumerState<EventRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event List')),
      body: const Center(
        child: Text(
          'Event Registration Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
