import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/settings/domain/models/location_context.dart';

void main() {
  group('LocationContext', () {
    test('builds display label from city and country', () {
      final context = LocationContext(
        timezoneId: 'Africa/Algiers',
        utcOffsetSeconds: 3600,
        city: 'Tamanrasset',
        country: 'Algeria',
        source: LocationContextSource.gpsApi,
        updatedAt: DateTime(2026),
      );

      expect(context.displayLabel, 'Tamanrasset, Algeria · UTC+01:00');
    });

    test('falls back to timezone id when city/country are missing', () {
      final context = LocationContext(
        timezoneId: 'Africa/Algiers',
        utcOffsetSeconds: 3600,
        source: LocationContextSource.deviceTimezone,
        updatedAt: DateTime(2026),
      );

      expect(context.displayLabel, 'Africa/Algiers · UTC+01:00');
    });
  });
}
