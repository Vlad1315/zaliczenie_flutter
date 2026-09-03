import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/app_localizations.dart';
import 'locale_provider.dart';
import 'router.dart';
import 'theme_provider.dart';

/// Root widget: wires up GoRouter, the FlexColorScheme light/dark themes
/// (point 10) with a GoogleFonts text theme (point 12), and localization
/// (point 9).
/// Rounded, card-based look (soft corners, pill buttons) inspired by
/// reference app screenshots the user shared.
const _subThemes = FlexSubThemesData(
  cardRadius: 20,
  elevatedButtonRadius: 28,
  outlinedButtonRadius: 28,
  textButtonRadius: 28,
  filledButtonRadius: 28,
  inputDecoratorRadius: 16,
  inputDecoratorIsFilled: true,
  navigationBarIndicatorRadius: 16,
  navigationBarElevation: 2,
);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final textTheme = GoogleFonts.poppinsTextTheme();

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: FlexThemeData.light(
        scheme: FlexScheme.money,
        useMaterial3: true,
        textTheme: textTheme,
        subThemesData: _subThemes,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.money,
        useMaterial3: true,
        textTheme: textTheme,
        subThemesData: _subThemes,
      ),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    );
  }
}
