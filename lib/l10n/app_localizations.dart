import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zaliczenie Flutter'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In pl, this message translates to:
  /// **'Notatki'**
  String get navHome;

  /// No description provided for @navMap.
  ///
  /// In pl, this message translates to:
  /// **'Mapa'**
  String get navMap;

  /// No description provided for @navSettings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get navSettings;

  /// No description provided for @homeTitle.
  ///
  /// In pl, this message translates to:
  /// **'Moje notatki'**
  String get homeTitle;

  /// No description provided for @homeHeroTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zorganizuj swój dzień'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Zapisuj pomysły, ustawiaj przypomnienia i miej pogodę pod ręką - wszystko w jednym miejscu.'**
  String get homeHeroSubtitle;

  /// No description provided for @notesEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Brak notatek. Dodaj pierwszą przyciskiem +.'**
  String get notesEmpty;

  /// No description provided for @addNote.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj notatkę'**
  String get addNote;

  /// No description provided for @editNote.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj notatkę'**
  String get editNote;

  /// No description provided for @noteTitleLabel.
  ///
  /// In pl, this message translates to:
  /// **'Tytuł'**
  String get noteTitleLabel;

  /// No description provided for @noteTitleHint.
  ///
  /// In pl, this message translates to:
  /// **'np. Zakupy'**
  String get noteTitleHint;

  /// No description provided for @noteTitleRequired.
  ///
  /// In pl, this message translates to:
  /// **'Tytuł jest wymagany'**
  String get noteTitleRequired;

  /// No description provided for @noteContentLabel.
  ///
  /// In pl, this message translates to:
  /// **'Treść'**
  String get noteContentLabel;

  /// No description provided for @noteContentHint.
  ///
  /// In pl, this message translates to:
  /// **'Treść notatki...'**
  String get noteContentHint;

  /// No description provided for @noteDateLabel.
  ///
  /// In pl, this message translates to:
  /// **'Data przypomnienia'**
  String get noteDateLabel;

  /// No description provided for @pickDate.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz datę'**
  String get pickDate;

  /// No description provided for @attachFile.
  ///
  /// In pl, this message translates to:
  /// **'Dołącz plik'**
  String get attachFile;

  /// No description provided for @attachedFile.
  ///
  /// In pl, this message translates to:
  /// **'Załącznik: {fileName}'**
  String attachedFile(String fileName);

  /// No description provided for @removeFile.
  ///
  /// In pl, this message translates to:
  /// **'Usuń załącznik'**
  String get removeFile;

  /// No description provided for @save.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pl, this message translates to:
  /// **'Anuluj'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In pl, this message translates to:
  /// **'Usuń'**
  String get delete;

  /// No description provided for @weatherSectionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Pogoda teraz'**
  String get weatherSectionTitle;

  /// No description provided for @weatherLoading.
  ///
  /// In pl, this message translates to:
  /// **'Pobieranie pogody...'**
  String get weatherLoading;

  /// No description provided for @weatherError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się pobrać pogody'**
  String get weatherError;

  /// No description provided for @weatherTemperature.
  ///
  /// In pl, this message translates to:
  /// **'Temperatura: {value}°C'**
  String weatherTemperature(String value);

  /// No description provided for @weatherWind.
  ///
  /// In pl, this message translates to:
  /// **'Wiatr: {value} km/h'**
  String weatherWind(String value);

  /// No description provided for @retry.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie'**
  String get retry;

  /// No description provided for @mapTitle.
  ///
  /// In pl, this message translates to:
  /// **'Mapa i lokalizacja'**
  String get mapTitle;

  /// No description provided for @myLocation.
  ///
  /// In pl, this message translates to:
  /// **'Moja lokalizacja'**
  String get myLocation;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In pl, this message translates to:
  /// **'Brak uprawnień do lokalizacji'**
  String get locationPermissionDenied;

  /// No description provided for @locationServiceDisabled.
  ///
  /// In pl, this message translates to:
  /// **'Usługi lokalizacji są wyłączone'**
  String get locationServiceDisabled;

  /// No description provided for @locationLoading.
  ///
  /// In pl, this message translates to:
  /// **'Ustalanie lokalizacji...'**
  String get locationLoading;

  /// No description provided for @settingsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settingsTitle;

  /// No description provided for @themeSection.
  ///
  /// In pl, this message translates to:
  /// **'Wygląd'**
  String get themeSection;

  /// No description provided for @themeMode.
  ///
  /// In pl, this message translates to:
  /// **'Motyw'**
  String get themeMode;

  /// No description provided for @themeLight.
  ///
  /// In pl, this message translates to:
  /// **'Jasny'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In pl, this message translates to:
  /// **'Ciemny'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In pl, this message translates to:
  /// **'Systemowy'**
  String get themeSystem;

  /// No description provided for @languageSection.
  ///
  /// In pl, this message translates to:
  /// **'Język'**
  String get languageSection;

  /// No description provided for @language.
  ///
  /// In pl, this message translates to:
  /// **'Język aplikacji'**
  String get language;

  /// No description provided for @languagePolish.
  ///
  /// In pl, this message translates to:
  /// **'Polski'**
  String get languagePolish;

  /// No description provided for @languageEnglish.
  ///
  /// In pl, this message translates to:
  /// **'Angielski'**
  String get languageEnglish;

  /// No description provided for @aboutSection.
  ///
  /// In pl, this message translates to:
  /// **'O aplikacji'**
  String get aboutSection;

  /// No description provided for @appConfigApiUrl.
  ///
  /// In pl, this message translates to:
  /// **'Adres API (z pliku .env): {url}'**
  String appConfigApiUrl(String url);

  /// No description provided for @noteSaved.
  ///
  /// In pl, this message translates to:
  /// **'Notatka zapisana'**
  String get noteSaved;

  /// No description provided for @noteDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Notatka usunięta'**
  String get noteDeleted;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In pl, this message translates to:
  /// **'Usunąć notatkę?'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In pl, this message translates to:
  /// **'Tej operacji nie można cofnąć.'**
  String get confirmDeleteMessage;

  /// No description provided for @yes.
  ///
  /// In pl, this message translates to:
  /// **'Tak'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In pl, this message translates to:
  /// **'Nie'**
  String get no;

  /// No description provided for @noteDetailsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Szczegóły notatki'**
  String get noteDetailsTitle;

  /// No description provided for @noNoteFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono notatki'**
  String get noNoteFound;

  /// No description provided for @cloudSection.
  ///
  /// In pl, this message translates to:
  /// **'Chmura (Firebase)'**
  String get cloudSection;

  /// No description provided for @cloudOpen.
  ///
  /// In pl, this message translates to:
  /// **'Otwórz czat w chmurze'**
  String get cloudOpen;

  /// No description provided for @cloudTitle.
  ///
  /// In pl, this message translates to:
  /// **'Wiadomości w chmurze'**
  String get cloudTitle;

  /// No description provided for @cloudExplainer.
  ///
  /// In pl, this message translates to:
  /// **'Publiczna tablica ogłoszeń (demo Firebase: logowanie anonimowe + Firestore w czasie rzeczywistym) - każdy, kto otworzy tę aplikację, widzi te same wiadomości.'**
  String get cloudExplainer;

  /// No description provided for @cloudSignedInAs.
  ///
  /// In pl, this message translates to:
  /// **'Zalogowano anonimowo jako: {uid}'**
  String cloudSignedInAs(String uid);

  /// No description provided for @cloudSigningIn.
  ///
  /// In pl, this message translates to:
  /// **'Logowanie...'**
  String get cloudSigningIn;

  /// No description provided for @cloudMessageHint.
  ///
  /// In pl, this message translates to:
  /// **'Napisz wiadomość...'**
  String get cloudMessageHint;

  /// No description provided for @cloudSend.
  ///
  /// In pl, this message translates to:
  /// **'Wyślij'**
  String get cloudSend;

  /// No description provided for @cloudEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Brak wiadomości. Bądź pierwszy!'**
  String get cloudEmpty;

  /// No description provided for @cloudError.
  ///
  /// In pl, this message translates to:
  /// **'Błąd połączenia z Firebase'**
  String get cloudError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
