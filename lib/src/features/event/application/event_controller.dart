import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/event_repository.dart';
import '../domain/models/event_model.dart';

class EventState {
  final bool isLoading;
  final List<EventModel>? events;
  final String? error;

  EventState({this.isLoading = false, this.events, this.error});

  EventState copyWith({
    bool? isLoading,
    List<EventModel>? events,
    String? error,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      error: error ?? this.error,
    );
  }
}

class EventController extends StateNotifier<EventState> {
  final EventRepository eventRepository;
  bool _isDisposed = false;

  EventController({required this.eventRepository}) : super(EventState());

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadEvents() async {
    try {
      if (_isDisposed) return;
      state = state.copyWith(isLoading: true, error: null);
      final events = await eventRepository.fetchEvents();
      if (_isDisposed) return;
      state = state.copyWith(isLoading: false, events: events);
    } catch (e) {
      if (!_isDisposed) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }
}

final eventControllerProvider =
    StateNotifierProvider<EventController, EventState>((ref) {
  final repo = ref.watch(eventRepositoryProvider).maybeWhen(
        data: (repo) => repo,
        orElse: () => EventRepository(),
      );
  return EventController(eventRepository: repo);
});
