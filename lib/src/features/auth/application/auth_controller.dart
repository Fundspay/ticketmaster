import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';
import '../domain/models/user_model.dart';
import '../domain/models/registration_model.dart';

class AuthState {
  final bool isLoading;
  final UserModel? user;
  final RegistrationModel? registration;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.user,
    this.registration,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    UserModel? user,
    RegistrationModel? registration,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      registration: registration ?? this.registration,
      error: error ?? this.error,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthController({required this.authRepository}) : super(AuthState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final user = await authRepository.login(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final registration = await authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, registration: registration);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider).maybeWhen(
        data: (repo) => repo,
        orElse: () => AuthRepository(),
      );
  return AuthController(authRepository: repo);
});
