// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Zaliczenie Flutter';

  @override
  String get navHome => 'Notatki';

  @override
  String get navMap => 'Mapa';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String get homeTitle => 'Moje notatki';

  @override
  String get homeHeroTitle => 'Zorganizuj swój dzień';

  @override
  String get homeHeroSubtitle =>
      'Zapisuj pomysły, ustawiaj przypomnienia i miej pogodę pod ręką - wszystko w jednym miejscu.';

  @override
  String get notesEmpty => 'Brak notatek. Dodaj pierwszą przyciskiem +.';

  @override
  String get addNote => 'Dodaj notatkę';

  @override
  String get editNote => 'Edytuj notatkę';

  @override
  String get noteTitleLabel => 'Tytuł';

  @override
  String get noteTitleHint => 'np. Zakupy';

  @override
  String get noteTitleRequired => 'Tytuł jest wymagany';

  @override
  String get noteContentLabel => 'Treść';

  @override
  String get noteContentHint => 'Treść notatki...';

  @override
  String get noteDateLabel => 'Data przypomnienia';

  @override
  String get pickDate => 'Wybierz datę';

  @override
  String get attachFile => 'Dołącz plik';

  @override
  String attachedFile(String fileName) {
    return 'Załącznik: $fileName';
  }

  @override
  String get removeFile => 'Usuń załącznik';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get weatherSectionTitle => 'Pogoda teraz';

  @override
  String get weatherLoading => 'Pobieranie pogody...';

  @override
  String get weatherError => 'Nie udało się pobrać pogody';

  @override
  String weatherTemperature(String value) {
    return 'Temperatura: $value°C';
  }

  @override
  String weatherWind(String value) {
    return 'Wiatr: $value km/h';
  }

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get mapTitle => 'Mapa i lokalizacja';

  @override
  String get myLocation => 'Moja lokalizacja';

  @override
  String get locationPermissionDenied => 'Brak uprawnień do lokalizacji';

  @override
  String get locationServiceDisabled => 'Usługi lokalizacji są wyłączone';

  @override
  String get locationLoading => 'Ustalanie lokalizacji...';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get themeSection => 'Wygląd';

  @override
  String get themeMode => 'Motyw';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get languageSection => 'Język';

  @override
  String get language => 'Język aplikacji';

  @override
  String get languagePolish => 'Polski';

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get aboutSection => 'O aplikacji';

  @override
  String appConfigApiUrl(String url) {
    return 'Adres API (z pliku .env): $url';
  }

  @override
  String get noteSaved => 'Notatka zapisana';

  @override
  String get noteDeleted => 'Notatka usunięta';

  @override
  String get confirmDeleteTitle => 'Usunąć notatkę?';

  @override
  String get confirmDeleteMessage => 'Tej operacji nie można cofnąć.';

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get noteDetailsTitle => 'Szczegóły notatki';

  @override
  String get noNoteFound => 'Nie znaleziono notatki';

  @override
  String get cloudSection => 'Chmura (Firebase)';

  @override
  String get cloudOpen => 'Otwórz czat w chmurze';

  @override
  String get cloudTitle => 'Wiadomości w chmurze';

  @override
  String get cloudExplainer =>
      'Publiczna tablica ogłoszeń (demo Firebase: logowanie anonimowe + Firestore w czasie rzeczywistym) - każdy, kto otworzy tę aplikację, widzi te same wiadomości.';

  @override
  String cloudSignedInAs(String uid) {
    return 'Zalogowano anonimowo jako: $uid';
  }

  @override
  String get cloudSigningIn => 'Logowanie...';

  @override
  String get cloudMessageHint => 'Napisz wiadomość...';

  @override
  String get cloudSend => 'Wyślij';

  @override
  String get cloudEmpty => 'Brak wiadomości. Bądź pierwszy!';

  @override
  String get cloudError => 'Błąd połączenia z Firebase';
}
