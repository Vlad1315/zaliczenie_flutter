import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/icon_badge.dart';
import '../../l10n/app_localizations.dart';
import 'providers/cloud_providers.dart';

/// Small chat backed by Firebase Auth (anonymous sign-in) and Firestore
/// (read/write) - point 7, Komunikacja z Firebase.
class CloudScreen extends ConsumerStatefulWidget {
  const CloudScreen({super.key});

  @override
  ConsumerState<CloudScreen> createState() => _CloudScreenState();
}

class _CloudScreenState extends ConsumerState<CloudScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send(String uid) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    await ref.read(cloudRepositoryProvider).sendMessage(text: text, authorUid: uid);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authStateProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cloudTitle)),
      body: switch (authState) {
        AsyncData(value: final user?) => _ChatBody(uid: user.uid, onSend: _send, controller: _controller),
        AsyncError() => Center(child: Text(l10n.cloudError)),
        _ => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l10n.cloudSigningIn),
              ],
            ),
          ),
      },
      backgroundColor: scheme.surface,
    );
  }
}

class _ChatBody extends ConsumerWidget {
  const _ChatBody({required this.uid, required this.onSend, required this.controller});

  final String uid;
  final Future<void> Function(String uid) onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final messagesAsync = ref.watch(cloudMessagesProvider);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Card(
            color: scheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 18, color: scheme.onSecondaryContainer),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.cloudExplainer,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: scheme.onSecondaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            l10n.cloudSignedInAs(uid.substring(0, uid.length.clamp(0, 8))),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: switch (messagesAsync) {
            AsyncData(:final value) when value.isEmpty => Center(child: Text(l10n.cloudEmpty)),
            AsyncData(:final value) => ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final message = value[index];
                  final isMine = message.authorUid == uid;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMine) ...[
                          IconBadge(icon: Icons.person_outline, color: scheme.secondary, size: 32),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? scheme.primaryContainer
                                  : scheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(message.text),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            AsyncError() => Center(child: Text(l10n.cloudError)),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: l10n.cloudMessageHint),
                    onSubmitted: (_) => onSend(uid),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => onSend(uid),
                  icon: const Icon(Icons.send),
                  tooltip: l10n.cloudSend,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
