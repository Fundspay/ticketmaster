import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/ticket_repository.dart';
import '../domain/models/ticket_model.dart';

class TicketState {
  final bool isLoading;
  final List<TicketModel>? tickets;
  final String? error;

  TicketState({this.isLoading = false, this.tickets, this.error});

  TicketState copyWith({bool? isLoading, List<TicketModel>? tickets, String? error}) {
    return TicketState(
      isLoading: isLoading ?? this.isLoading,
      tickets: tickets ?? this.tickets,
      error: error ?? this.error,
    );
  }
}

class TicketController extends StateNotifier<TicketState> {
  final TicketRepository ticketRepository;
  bool _isDisposed = false; // ticket issue solution

  TicketController({required this.ticketRepository}) : super(TicketState());

  @override
  void dispose() {
    _isDisposed = true; // ticket issue solution
    super.dispose();
  }

  Future<void> loadTickets(String userId) async {
    try {
      if (_isDisposed) return; // ticket issue solution
      state = state.copyWith(isLoading: true, error: null); // ticket issue solution
      final tickets = await ticketRepository.fetchTickets(userId: userId);
      if (_isDisposed) return; // ticket issue solution
      state = state.copyWith(isLoading: false, tickets: tickets); // ticket issue solution
    } catch (e) {
      if (!_isDisposed) { // ticket issue solution
        state = state.copyWith(isLoading: false, error: e.toString()); // ticket issue solution
      }
      debugPrint("Error in loadTickets: $e"); // ticket issue solution
    }
  }
}

final ticketControllerProvider =
    StateNotifierProvider<TicketController, TicketState>((ref) {
  final repo = ref.watch(ticketRepositoryProvider).maybeWhen(
        data: (repo) => repo,
        orElse: () => TicketRepository(),
      );
  return TicketController(ticketRepository: repo);
});
