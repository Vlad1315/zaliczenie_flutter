import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) => LocationService());

/// Async current-device position, consumed with AsyncValue.when/switch
/// both on the map screen and by the weather provider
/// (point 2 - obsługa stanu future/async/switch - Riverpod).
final currentPositionProvider = FutureProvider<Position>((ref) {
  return ref.watch(locationServiceProvider).getCurrentPosition();
});
