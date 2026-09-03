import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

/// Holds the current app [Locale] and persists it with SharedPreferences
/// (point 9 - wybór języka - i18n/l10n).
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final saved = ref.read(prefsServiceProvider).localeCode;
    return Locale(saved ?? 'pl');
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref.read(prefsServiceProvider).setLocaleCode(locale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
