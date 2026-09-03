import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/note.dart';

/// CRUD access to the local Isar (community) object database
/// (point 6 - baza danych obiektowa na urządzeniu).
class NotesRepository {
  NotesRepository(this._isar);

  final Isar _isar;

  static Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open([NoteSchema], directory: dir.path);
  }

  Stream<List<Note>> watchAll() {
    return _isar.notes.where().sortByCreatedAtDesc().watch(fireImmediately: true);
  }

  Future<Note?> getById(int id) => _isar.notes.get(id);

  Future<int> save(Note note) {
    return _isar.writeTxn(() => _isar.notes.put(note));
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.notes.delete(id));
  }
}
