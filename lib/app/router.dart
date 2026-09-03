import 'package:go_router/go_router.dart';

import '../features/cloud/cloud_screen.dart';
import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/note_details/note_details_screen.dart';
import '../features/note_form/note_form_screen.dart';
import '../features/settings/settings_screen.dart';
import 'scaffold_with_nav.dart';

/// App-wide navigation graph using named routes, push/pop and go/replace
/// (point 1 - Nawigacja - GoRouter).
final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithNav(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/map',
          name: 'map',
          builder: (context, state) => const MapScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/cloud',
      name: 'cloud',
      builder: (context, state) => const CloudScreen(),
    ),
    GoRoute(
      path: '/note/new',
      name: 'noteNew',
      builder: (context, state) => const NoteFormScreen(),
    ),
    GoRoute(
      path: '/note/:id',
      name: 'noteDetails',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return NoteDetailsScreen(noteId: id);
      },
    ),
    GoRoute(
      path: '/note/:id/edit',
      name: 'noteEdit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return NoteFormScreen(noteId: id);
      },
    ),
  ],
);
