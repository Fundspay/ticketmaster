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
  TicketController({required this.ticketRepository}) : super(TicketState());

  Future<void> loadTickets(String userId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final tickets = await ticketRepository.fetchTickets(userId: userId);
      state = state.copyWith(isLoading: false, tickets: tickets);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      debugPrint("Error in loadTickets: $e"); // printing id change here
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
