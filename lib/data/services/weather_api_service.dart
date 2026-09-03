import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../models/weather.dart';

/// Talks to the free Open-Meteo REST API using Dio.
/// The base URL comes from the .env file via Envied (point 4).
class WeatherApiService {
  WeatherApiService() : _dio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl));

  final Dio _dio;

  Future<WeatherResponse> fetchCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/forecast',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current_weather': true,
      },
    );
    return WeatherResponse.fromJson(response.data!);
  }
}
