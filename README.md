# Zaliczenie Flutter

Prosta aplikacja "Notatki + pogoda + mapa", która pokazuje wszystkie wymagane
zagadnienia z listy zaliczeniowej.

## Mapowanie wymagań na kod

| # | Zagadnienie | Gdzie w kodzie |
|---|---|---|
| 1 | Nawigacja - GoRouter | [`lib/app/router.dart`](lib/app/router.dart), [`lib/app/scaffold_with_nav.dart`](lib/app/scaffold_with_nav.dart) - named routes, `push`/`pop`/`go` |
| 2 | Riverpod, future/async, switch | [`lib/features/home/providers/weather_provider.dart`](lib/features/home/providers/weather_provider.dart), [`notes_provider.dart`](lib/features/home/providers/notes_provider.dart), obsługa `AsyncValue` przez `switch` w [`home_screen.dart`](lib/features/home/home_screen.dart) i [`map_screen.dart`](lib/features/map/map_screen.dart) |
| 3 | Dio + JSON (freezed) | [`lib/data/services/weather_api_service.dart`](lib/data/services/weather_api_service.dart), model [`lib/data/models/weather.dart`](lib/data/models/weather.dart) |
| 4 | .env + Envied | plik [`.env`](.env), [`lib/env/env.dart`](lib/env/env.dart) |
| 5 | SharedPreferences | [`lib/data/services/prefs_service.dart`](lib/data/services/prefs_service.dart) - zapis motywu i języka |
| 6 | Baza obiektowa (Isar Community) | [`lib/data/models/note.dart`](lib/data/models/note.dart), [`lib/data/services/notes_repository.dart`](lib/data/services/notes_repository.dart) |
| 7 | Firebase - zapis/odczyt, uwierzytelnianie | [`lib/main.dart`](lib/main.dart) (anonimowe logowanie), [`lib/data/services/cloud_repository.dart`](lib/data/services/cloud_repository.dart), [`lib/features/cloud/cloud_screen.dart`](lib/features/cloud/cloud_screen.dart) - mini-czat w Firestore, otwierany z Ustawień |
| 8 | Mapa i lokalizacja | [`lib/features/map/map_screen.dart`](lib/features/map/map_screen.dart) (flutter_map + OpenStreetMap, bez klucza API), [`lib/common/location_service.dart`](lib/common/location_service.dart) (geolocator) |
| 9 | i18n / l10n | [`lib/l10n/app_pl.arb`](lib/l10n/app_pl.arb), [`app_en.arb`](lib/l10n/app_en.arb), przełącznik języka w [`settings_screen.dart`](lib/features/settings/settings_screen.dart) |
| 10 | Dark/Light mode - FlexColorScheme | [`lib/app/app.dart`](lib/app/app.dart), [`lib/app/theme_provider.dart`](lib/app/theme_provider.dart) |
| 11 | Przyciski i formularz | [`lib/features/note_form/note_form_screen.dart`](lib/features/note_form/note_form_screen.dart) - pola tekstowe, date picker, file picker, przyciski z ikoną/tekstem |
| 12 | GoogleFonts | użyty w [`lib/app/app.dart`](lib/app/app.dart) (`GoogleFonts.poppinsTextTheme()`) |

Zaimplementowano wszystkie 5 pogrubionych punktów oraz 7 niepogrubionych
(wymagane były tylko 4) - pominięty został wyłącznie wybór między Isar a
ObjectBox w pkt. 6 (wybrano Isar Community).

## Konfiguracja Firebase (WYMAGANE przed uruchomieniem pkt. 7)

`android/app/google-services.json` już jest w projekcie (projekt Firebase:
`zaliczenie-flutter`), ale w konsoli Firebase trzeba jeszcze włączyć dwie
rzeczy, inaczej ekran "Chmura" w Ustawieniach pokaże błąd:

1. [console.firebase.google.com](https://console.firebase.google.com) →
   projekt `zaliczenie-flutter` → **Build → Authentication** → "Get
   started" → zakładka **Sign-in method** → włącz dostawcę **Anonymous**.
2. Tam samo → **Build → Firestore Database** → **Create database** →
   wybierz dowolny region → uruchom **w trybie testowym** (test mode) -
   to wystarczy na potrzeby zaliczenia (reguły wygasają po ~30 dniach,
   można je potem przedłużyć w zakładce Rules).

## Wymagania środowiskowe

- Flutter SDK znaleziony w `D:\flutter` (wersja 3.47.2) - nie jest jeszcze
  dodany do zmiennej PATH w Windows. Aby korzystać z `flutter` bezpośrednio
  z terminala, dodaj `D:\flutter\bin` do PATH samodzielnie (Ustawienia →
  Zmienne środowiskowe), albo po prostu otwórz projekt w Android Studio -
  wystarczy wskazać tam SDK Fluttera (patrz niżej).
- Android Studio ma być skonfigurowane z wtyczkami **Flutter** i **Dart**
  (Settings → Plugins). Jeśli ich nie ma, doinstaluj przez markplace w IDE.
- W Android Studio: File → Settings → Languages & Frameworks → Flutter →
  ustaw "Flutter SDK path" na `D:\flutter`.

## Uruchomienie

1. Otwórz folder `D:\projekty\zaliczenie_flutter` w Android Studio ("Open").
2. Poczekaj aż IDE pobierze/zindeksuje zależności (albo w terminalu:
   `flutter pub get`).
3. Uruchom emulator Androida (Device Manager) lub podłącz telefon z
   włączonym debugowaniem USB.
4. Kliknij Run (▶) albo w terminalu: `flutter run`.

Uwaga: przy pierwszym uruchomieniu aplikacja poprosi o uprawnienia do
lokalizacji (potrzebne dla pogody i mapy) - zaakceptuj je na
urządzeniu/emulatorze.

## Znane obejścia specyficzne dla tego komputera

- `android/gradle.properties` ma dodane `kotlin.incremental=false` - bez
  tego build Gradle wywala się na Windows, gdy projekt i cache Pub/Gradle
  są na różnych literach dysku (tu: projekt na `D:`, cache na `C:`).
- `android/app/build.gradle.kts` ma `compileSdk = 37`, bo wymaga tego
  wtyczka `permission_handler_android`.

## Testy i analiza

- `flutter analyze` - przechodzi bez błędów.
- `flutter build apk --debug` - buduje się poprawnie (sprawdzone).
- `flutter test` może nie odpalić się lokalnie z powodu polityki
  "Application Control" na tym Windowsie blokującej `flutter_tester.exe` -
  to ograniczenie systemowe niezwiązane z kodem aplikacji.

## Wysyłka na zaliczenie

1. Zainicjuj repozytorium Git i wypchnij na GitHub/GitLab (folder ma już
   gotowy `.gitignore`).
2. Nagraj krótkie wideo pokazujące działanie każdego z 9 zaimplementowanych
   punktów (nawigacja, dodawanie/edycja/usuwanie notatki z datą i plikiem,
   pogoda, mapa z lokalizacją, zmiana motywu, zmiana języka) i wrzuć na
   Google Drive / YouTube zgodnie z wymaganiami.
