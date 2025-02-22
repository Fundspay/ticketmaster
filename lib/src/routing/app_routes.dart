import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/home/presentation/main_home_screen.dart'; // Updated import
import '../features/event/presentation/event_list_screen.dart';
import '../features/registration/presentation/event_registration_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const MainHomeScreen(),
    ),
    GoRoute(
      path: '/events',
      name: 'eventList',
      builder: (context, state) => const EventListScreen(),
    ),
    GoRoute(
      path: '/event-registration',
      name: 'eventRegistration',
      builder: (context, state) => const EventRegistrationScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
