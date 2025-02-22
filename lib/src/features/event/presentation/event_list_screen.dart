import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketmaster/src/features/event/application/event_controller.dart';
import 'package:ticketmaster/src/features/event/domain/models/event_model.dart';

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
      builder: (context) => Padding(
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
