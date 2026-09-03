import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/locale_provider.dart';
import '../../app/theme_provider.dart';
import '../../common/icon_badge.dart';
import '../../env/env.dart';
import '../../l10n/app_localizations.dart';

/// Dark/light mode switch (point 10 - FlexColorScheme) and language
/// switch (point 9 - i18n/l10n), plus a peek at the .env config
/// (point 4 - Envied).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader(icon: Icons.palette_outlined, color: scheme.primary, title: l10n.themeSection),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.light, label: Text(l10n.themeLight), icon: const Icon(Icons.light_mode)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark), icon: const Icon(Icons.dark_mode)),
              ButtonSegment(value: ThemeMode.system, label: Text(l10n.themeSystem), icon: const Icon(Icons.brightness_auto)),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) {
              ref.read(themeModeProvider.notifier).setThemeMode(selection.first);
            },
          ),
          const SizedBox(height: 32),
          _SectionHeader(icon: Icons.translate, color: scheme.secondary, title: l10n.languageSection),
          const SizedBox(height: 12),
          SegmentedButton<Locale>(
            segments: [
              ButtonSegment(value: const Locale('pl'), label: Text(l10n.languagePolish)),
              ButtonSegment(value: const Locale('en'), label: Text(l10n.languageEnglish)),
            ],
            selected: {Locale(locale.languageCode)},
            onSelectionChanged: (selection) {
              ref.read(localeProvider.notifier).setLocale(selection.first);
            },
          ),
          const SizedBox(height: 32),
          _SectionHeader(icon: Icons.info_outline, color: scheme.tertiary, title: l10n.aboutSection),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Env.appName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(l10n.appConfigApiUrl(Env.apiBaseUrl)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _SectionHeader(icon: Icons.cloud_outlined, color: scheme.primary, title: l10n.cloudSection),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.pushNamed('cloud'),
            icon: const Icon(Icons.chat_bubble_outline),
            label: Text(l10n.cloudOpen),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.color, required this.title});

  final IconData icon;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBadge(icon: icon, color: color, size: 32),
        const SizedBox(width: 10),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
