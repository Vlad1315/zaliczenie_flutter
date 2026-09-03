import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../data/models/note.dart';
import '../../l10n/app_localizations.dart';

/// Add/edit screen showing point 11 requirements: text buttons, an
/// icon+text button, a text form with fields, a date picker and a file
/// picker.
class NoteFormScreen extends ConsumerStatefulWidget {
  const NoteFormScreen({super.key, this.noteId});

  final int? noteId;

  @override
  ConsumerState<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends ConsumerState<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  DateTime? _reminderDate;
  String? _attachmentPath;
  String? _attachmentName;
  bool _loading = true;
  int? _existingId;

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    if (widget.noteId != null) {
      final note = await ref.read(notesRepositoryProvider).getById(widget.noteId!);
      if (note != null) {
        _existingId = note.id;
        _titleController.text = note.title;
        _contentController.text = note.content;
        _reminderDate = note.reminderDate;
        _attachmentPath = note.attachmentPath;
        _attachmentName = note.attachmentName;
      }
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _reminderDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() => _reminderDate = picked);
    }
  }

  Future<void> _pickFile() async {
    final file = await FilePicker.pickFile();
    if (file != null && file.path != null) {
      setState(() {
        _attachmentPath = file.path;
        _attachmentName = file.name;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final note = Note()
      ..title = _titleController.text.trim()
      ..content = _contentController.text.trim()
      ..reminderDate = _reminderDate
      ..attachmentPath = _attachmentPath
      ..attachmentName = _attachmentName
      ..createdAt = DateTime.now();
    if (_existingId != null) {
      note.id = _existingId!;
    }

    await ref.read(notesRepositoryProvider).save(note);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.noteId != null;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(isEditing ? l10n.editNote : l10n.addNote)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? l10n.editNote : l10n.addNote)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.noteTitleLabel,
                hintText: l10n.noteTitleHint,
              ),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? l10n.noteTitleRequired : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: l10n.noteContentLabel,
                hintText: l10n.noteContentHint,
              ),
              minLines: 3,
              maxLines: 6,
            ),
            const SizedBox(height: 16),
            Text(l10n.noteDateLabel, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _reminderDate == null
                    ? l10n.pickDate
                    : DateFormat.yMMMMd().format(_reminderDate!),
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.attachFile, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: Text(l10n.attachFile),
                ),
                if (_attachmentName != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.attachedFile(_attachmentName!),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.removeFile,
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _attachmentPath = null;
                      _attachmentName = null;
                    }),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(l10n.cancel),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: Text(l10n.save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
