import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

/// Response of the free Open-Meteo API, fetched with Dio
/// (point 3 - komunikacja z zewn. API - DIO, JSON freeze).
@freezed
abstract class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required double latitude,
    required double longitude,
    @JsonKey(name: 'current_weather') required CurrentWeather currentWeather,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

@freezed
abstract class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required double temperature,
    required double windspeed,
    @JsonKey(name: 'weathercode') required int weatherCode,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}
