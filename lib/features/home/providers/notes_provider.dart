import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../data/models/note.dart';

/// Live stream of all notes from Isar, exposed as an AsyncValue
/// (point 2 - obsługa stanu future/async/switch - Riverpod).
final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  return ref.watch(notesRepositoryProvider).watchAll();
});
