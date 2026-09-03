import 'package:isar_community/isar.dart';

part 'note.g.dart';

/// Local object stored in the Isar (community) database
/// (point 6 - baza danych obiektowa na urządzeniu).
@collection
class Note {
  Id id = Isar.autoIncrement;

  late String title;

  late String content;

  DateTime? reminderDate;

  /// Absolute path to an optional attached file, picked with file_picker.
  String? attachmentPath;

  String? attachmentName;

  late DateTime createdAt;
}
