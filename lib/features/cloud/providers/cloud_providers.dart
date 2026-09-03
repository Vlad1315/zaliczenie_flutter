import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/cloud_message.dart';
import '../../../data/services/cloud_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// Anonymous auth state stream (point 7 - uwierzytelnianie).
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final cloudRepositoryProvider = Provider<CloudRepository>((ref) {
  return CloudRepository(FirebaseFirestore.instance);
});

/// Live list of Firestore messages, handled with AsyncValue (point 2).
final cloudMessagesProvider = StreamProvider<List<CloudMessage>>((ref) {
  return ref.watch(cloudRepositoryProvider).watchMessages();
});
