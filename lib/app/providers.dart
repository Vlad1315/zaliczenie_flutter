import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../data/services/notes_repository.dart';
import '../data/services/prefs_service.dart';
import '../data/services/weather_api_service.dart';

/// Base infrastructure providers. The [isarProvider] and
/// [prefsServiceProvider] are overridden in `main.dart` with the real
/// instances created during the async app bootstrap, since opening the
/// Isar database and SharedPreferences requires awaiting a Future before
/// [runApp] is called.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider must be overridden in main()');
});

final prefsServiceProvider = Provider<PrefsService>((ref) {
  throw UnimplementedError('prefsServiceProvider must be overridden in main()');
});

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  return NotesRepository(ref.watch(isarProvider));
});

final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiService();
});
