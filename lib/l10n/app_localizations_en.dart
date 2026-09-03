// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Credit Project';

  @override
  String get navHome => 'Notes';

  @override
  String get navMap => 'Map';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeTitle => 'My notes';

  @override
  String get homeHeroTitle => 'Organize your day';

  @override
  String get homeHeroSubtitle =>
      'Jot down ideas, set reminders and keep the weather at hand - all in one place.';

  @override
  String get notesEmpty => 'No notes yet. Add one with the + button.';

  @override
  String get addNote => 'Add note';

  @override
  String get editNote => 'Edit note';

  @override
  String get noteTitleLabel => 'Title';

  @override
  String get noteTitleHint => 'e.g. Groceries';

  @override
  String get noteTitleRequired => 'Title is required';

  @override
  String get noteContentLabel => 'Content';

  @override
  String get noteContentHint => 'Note content...';

  @override
  String get noteDateLabel => 'Reminder date';

  @override
  String get pickDate => 'Pick a date';

  @override
  String get attachFile => 'Attach file';

  @override
  String attachedFile(String fileName) {
    return 'Attachment: $fileName';
  }

  @override
  String get removeFile => 'Remove attachment';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get weatherSectionTitle => 'Weather now';

  @override
  String get weatherLoading => 'Loading weather...';

  @override
  String get weatherError => 'Failed to load weather';

  @override
  String weatherTemperature(String value) {
    return 'Temperature: $value°C';
  }

  @override
  String weatherWind(String value) {
    return 'Wind: $value km/h';
  }

  @override
  String get retry => 'Retry';

  @override
  String get mapTitle => 'Map and location';

  @override
  String get myLocation => 'My location';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get locationServiceDisabled => 'Location services are disabled';

  @override
  String get locationLoading => 'Locating...';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSection => 'Appearance';

  @override
  String get themeMode => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageSection => 'Language';

  @override
  String get language => 'App language';

  @override
  String get languagePolish => 'Polish';

  @override
  String get languageEnglish => 'English';

  @override
  String get aboutSection => 'About';

  @override
  String appConfigApiUrl(String url) {
    return 'API URL (from .env file): $url';
  }

  @override
  String get noteSaved => 'Note saved';

  @override
  String get noteDeleted => 'Note deleted';

  @override
  String get confirmDeleteTitle => 'Delete this note?';

  @override
  String get confirmDeleteMessage => 'This action cannot be undone.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get noteDetailsTitle => 'Note details';

  @override
  String get noNoteFound => 'Note not found';

  @override
  String get cloudSection => 'Cloud (Firebase)';

  @override
  String get cloudOpen => 'Open cloud chat';

  @override
  String get cloudTitle => 'Cloud messages';

  @override
  String get cloudExplainer =>
      'A public message board (Firebase demo: anonymous sign-in + real-time Firestore) - everyone who opens this app sees the same messages.';

  @override
  String cloudSignedInAs(String uid) {
    return 'Signed in anonymously as: $uid';
  }

  @override
  String get cloudSigningIn => 'Signing in...';

  @override
  String get cloudMessageHint => 'Write a message...';

  @override
  String get cloudSend => 'Send';

  @override
  String get cloudEmpty => 'No messages yet. Be the first!';

  @override
  String get cloudError => 'Failed to connect to Firebase';
}
