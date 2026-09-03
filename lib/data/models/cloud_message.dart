import 'package:cloud_firestore/cloud_firestore.dart';

/// A single chat-style message stored in the `messages` Firestore
/// collection (point 7 - Firebase, zapis/odczyt).
class CloudMessage {
  const CloudMessage({
    required this.id,
    required this.text,
    required this.authorUid,
    required this.createdAt,
  });

  final String id;
  final String text;
  final String authorUid;
  final DateTime? createdAt;

  factory CloudMessage.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CloudMessage(
      id: doc.id,
      text: data['text'] as String? ?? '',
      authorUid: data['authorUid'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
