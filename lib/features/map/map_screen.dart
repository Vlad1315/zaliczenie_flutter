import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../common/location_provider.dart';
import '../../common/location_service.dart';
import '../../l10n/app_localizations.dart';

/// Shows a map (OpenStreetMap tiles via flutter_map, no API key required)
/// centered on the device's GPS location (point 8 - Mapa, lokalizacja).
class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final positionAsync = ref.watch(currentPositionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mapTitle)),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.myLocation,
        onPressed: () => ref.invalidate(currentPositionProvider),
        child: const Icon(Icons.my_location),
      ),
      body: switch (positionAsync) {
        AsyncData(:final value) => FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(value.latitude, value.longitude),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.zaliczenie_flutter',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(value.latitude, value.longitude),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 36),
                  ),
                ],
              ),
            ],
          ),
        AsyncError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                error is LocationPermissionDeniedException
                    ? l10n.locationPermissionDenied
                    : error is LocationServiceDisabledException
                        ? l10n.locationServiceDisabled
                        : l10n.weatherError,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        _ => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l10n.locationLoading),
              ],
            ),
          ),
      },
    );
  }
}
