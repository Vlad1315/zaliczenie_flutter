import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../common/location_provider.dart';
import '../../../data/models/weather.dart';

/// Fetches current weather for the device's location through Dio
/// (point 3 - komunikacja z zewn. API - DIO, JSON freeze).
final weatherProvider = FutureProvider<WeatherResponse>((ref) async {
  final position = await ref.watch(currentPositionProvider.future);
  final api = ref.watch(weatherApiServiceProvider);
  return api.fetchCurrentWeather(
    latitude: position.latitude,
    longitude: position.longitude,
  );
});
