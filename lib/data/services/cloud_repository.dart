import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cloud_message.dart';

/// Reads and writes the shared `messages` collection in Firestore
/// (point 7 - komunikacja z Firebase - zapis/odczyt).
class CloudRepository {
  CloudRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _messages =>
      _firestore.collection('messages');

  Stream<List<CloudMessage>> watchMessages() {
    return _messages
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(CloudMessage.fromDoc).toList());
  }

  Future<void> sendMessage({required String text, required String authorUid}) {
    return _messages.add({
      'text': text,
      'authorUid': authorUid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
