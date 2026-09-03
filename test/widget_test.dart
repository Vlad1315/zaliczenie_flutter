// Basic sanity test for the SharedPreferences wrapper used for point 5
// (SharedPreferences i GetStorage).

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zaliczenie_flutter/data/services/prefs_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('PrefsService persists theme mode and locale', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await PrefsService.create();

    expect(prefs.themeMode, isNull);
    expect(prefs.localeCode, isNull);

    await prefs.setThemeMode('dark');
    await prefs.setLocaleCode('en');

    expect(prefs.themeMode, 'dark');
    expect(prefs.localeCode, 'en');
  });
}
