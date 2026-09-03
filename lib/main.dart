import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'data/services/notes_repository.dart';
import 'data/services/prefs_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await NotesRepository.openIsar();
  final prefsService = await PrefsService.create();

  await Firebase.initializeApp();
  // Silent anonymous sign-in so the Firestore chat has an authenticated
  // author for every message (point 7 - uwierzytelnianie).
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        prefsServiceProvider.overrideWithValue(prefsService),
      ],
      child: const App(),
    ),
  );
}
