import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/icon_badge.dart';
import '../../data/models/note.dart';
import '../../l10n/app_localizations.dart';
import 'providers/notes_provider.dart';
import 'providers/weather_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(weatherProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _HeroCard(),
            const SizedBox(height: 16),
            const _WeatherCard(),
            const SizedBox(height: 16),
            // AsyncValue is handled with a switch expression, showing the
            // future/async state machine required by point 2 (Riverpod).
            switch (notesAsync) {
              AsyncData(:final value) when value.isEmpty =>
                _EmptyNotes(message: l10n.notesEmpty),
              AsyncData(:final value) => Column(
                  children: [
                    for (final note in value) ...[
                      _NoteTile(note: note),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              AsyncError() => _EmptyNotes(message: l10n.weatherError),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed('noteNew'),
        icon: const Icon(Icons.add),
        label: Text(l10n.addNote),
      ),
    );
  }
}

/// Big welcome card at the top of the home feed, styled after the
/// reference app's "Odkrywaj miasto po swojemu" hero card: tinted
/// background, headline, subtitle and a primary pill button.
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.primaryContainer,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.auto_awesome, color: scheme.onPrimaryContainer),
            const SizedBox(height: 12),
            Text(
              l10n.homeHeroTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.homeHeroSubtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: scheme.onPrimaryContainer),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.pushNamed('noteNew'),
              icon: const Icon(Icons.add),
              label: Text(l10n.addNote),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherCard extends ConsumerWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final weatherAsync = ref.watch(weatherProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(
                  icon: Icons.wb_sunny_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.weatherSectionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            switch (weatherAsync) {
              AsyncData(:final value) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.weatherTemperature(
                      value.currentWeather.temperature.toStringAsFixed(1),
                    )),
                    Text(l10n.weatherWind(
                      value.currentWeather.windspeed.toStringAsFixed(1),
                    )),
                  ],
                ),
              AsyncError() => Row(
                  children: [
                    Expanded(child: Text(l10n.weatherError)),
                    TextButton(
                      onPressed: () => ref.invalidate(weatherProvider),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              _ => Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Text(l10n.weatherLoading),
                  ],
                ),
            },
          ],
        ),
      ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  const _NoteTile({required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: IconBadge(
          icon: note.reminderDate != null ? Icons.event_note : Icons.note_outlined,
          color: scheme.tertiary,
        ),
        title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushNamed(
          'noteDetails',
          pathParameters: {'id': note.id.toString()},
        ),
      ),
    );
  }
}

class _EmptyNotes extends StatelessWidget {
  const _EmptyNotes({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
