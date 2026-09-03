import 'package:envied/envied.dart';

part 'env.g.dart';

/// Configuration values loaded from the `.env` file at build time
/// (point 4 - Konfiguracja aplikacji .env - Envied).
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'APP_NAME')
  static final String appName = _Env.appName;

  @EnviedField(varName: 'APP_API_KEY')
  static final String appApiKey = _Env.appApiKey;
}
