import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../common/icon_badge.dart';
import '../../data/models/note.dart';
import '../../l10n/app_localizations.dart';

class NoteDetailsScreen extends ConsumerWidget {
  const NoteDetailsScreen({super.key, required this.noteId});

  final int noteId;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmDeleteTitle),
        content: Text(l10n.confirmDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(l10n.no),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(l10n.yes),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(notesRepositoryProvider).delete(noteId);
      if (context.mounted) context.goNamed('home');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.noteDetailsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.pushNamed(
              'noteEdit',
              pathParameters: {'id': noteId.toString()},
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: FutureBuilder<Note?>(
        future: ref.read(notesRepositoryProvider).getById(noteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final note = snapshot.data;
          if (note == null) {
            return Center(child: Text(l10n.noNoteFound));
          }
          final scheme = Theme.of(context).colorScheme;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBadge(
                    icon: note.reminderDate != null ? Icons.event_note : Icons.note_outlined,
                    color: scheme.tertiary,
                    size: 48,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(note.title, style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.content),
                      if (note.reminderDate != null) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 18),
                            const SizedBox(width: 8),
                            Text(DateFormat.yMMMMd().format(note.reminderDate!)),
                          ],
                        ),
                      ],
                      if (note.attachmentName != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_file, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(note.attachmentName!)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
