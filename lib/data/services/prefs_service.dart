import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences used to persist small user
/// settings on the device (point 5 - SharedPreferences i GetStorage).
class PrefsService {
  PrefsService(this._prefs);

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale_code';

  final SharedPreferences _prefs;

  static Future<PrefsService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefsService(prefs);
  }

  String? get themeMode => _prefs.getString(_themeModeKey);

  Future<void> setThemeMode(String value) => _prefs.setString(_themeModeKey, value);

  String? get localeCode => _prefs.getString(_localeKey);

  Future<void> setLocaleCode(String value) => _prefs.setString(_localeKey, value);
}
