import 'dart:convert';
import 'dart:io';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/settings/domain/models/location_context.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class LocationContextResolver {
  const LocationContextResolver({
    this.httpClientFactory,
    this.now,
  });

  final HttpClient Function()? httpClientFactory;
  final DateTime Function()? now;

  static const _timeApiHost = 'timeapi.io';
  static bool _tzInitialized = false;

  Future<LocationContext> resolve({
    required String localeCode,
    required LocationMode mode,
    String? manualTimezoneId,
    LocationContext? cached,
    bool allowPermissionPrompt = false,
  }) async {
    if (mode == LocationMode.manual &&
        manualTimezoneId != null &&
        manualTimezoneId.trim().isNotEmpty) {
      return _fromTimezoneOnly(
        manualTimezoneId.trim(),
        source: LocationContextSource.manual,
      );
    }

    final coordinate = await _resolveCoordinate(
      allowPermissionPrompt: allowPermissionPrompt,
    );

    if (coordinate != null) {
      final timezone = await _resolveTimezoneFromApi(coordinate);
      if (timezone != null) {
        final place = await _resolvePlace(
          coordinate.latitude,
          coordinate.longitude,
          localeCode,
        );

        return LocationContext(
          timezoneId: timezone.timezoneId,
          utcOffsetSeconds: timezone.utcOffsetSeconds,
          city: place?.city,
          country: place?.country,
          source: LocationContextSource.gpsApi,
          updatedAt: _now(),
        );
      }
    }

    if (cached != null) {
      return cached.copyWith(
        source: LocationContextSource.cache,
        updatedAt: _now(),
      );
    }

    final device = await _resolveDeviceTimezone(localeCode);
    if (device != null) {
      return device;
    }

    return _fromTimezoneOnly('UTC', source: LocationContextSource.utcFallback);
  }

  Future<GeoPoint?> _resolveCoordinate({
    required bool allowPermissionPrompt,
  }) async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && allowPermissionPrompt) {
        permission = await Geolocator.requestPermission();
      }

      final canUseLocation =
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;

      if (!canUseLocation) {
        return null;
      }

      try {
        final current = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: Duration(seconds: 6),
          ),
        );
        return GeoPoint(current.latitude, current.longitude);
      } on Exception {
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown == null) {
          return null;
        }
        return GeoPoint(lastKnown.latitude, lastKnown.longitude);
      }
    } on Exception {
      return null;
    }
  }

  Future<_ResolvedTimezone?> _resolveTimezoneFromApi(GeoPoint point) async {
    final client = (httpClientFactory ?? HttpClient.new)();
    try {
      final uri = Uri.https(_timeApiHost, '/api/v1/timezone/coordinate', {
        'latitude': point.latitude.toString(),
        'longitude': point.longitude.toString(),
      });

      final request = await client
          .getUrl(uri)
          .timeout(const Duration(seconds: 6));
      final response = await request.close().timeout(
        const Duration(seconds: 8),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }

      final body = await utf8.decodeStream(response);
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return null;
      }

      final timezoneId = (json['timezone'] as String?)?.trim();
      final utcOffsetSeconds = json['current_utc_offset_seconds'];
      if (timezoneId == null || timezoneId.isEmpty) {
        return null;
      }

      if (utcOffsetSeconds is! num) {
        return null;
      }

      return _ResolvedTimezone(timezoneId, utcOffsetSeconds.toInt());
    } on Exception {
      return null;
    } finally {
      client.close(force: true);
    }
  }

  Future<_ResolvedPlace?> _resolvePlace(
    double latitude,
    double longitude,
    String localeCode,
  ) async {
    try {
      final localeIdentifier = _mapLocaleIdentifier(localeCode);
      await setLocaleIdentifier(localeIdentifier);
      final marks = await placemarkFromCoordinates(latitude, longitude);
      if (marks.isEmpty) {
        return null;
      }

      final mark = marks.first;
      final city = _firstNonEmpty([
        mark.locality,
        mark.subAdministrativeArea,
        mark.administrativeArea,
      ]);
      final country = _firstNonEmpty([mark.country]);
      return _ResolvedPlace(city: city, country: country);
    } on Exception {
      return null;
    }
  }

  Future<LocationContext?> _resolveDeviceTimezone(String localeCode) async {
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone(localeCode);
      final identifier = timezoneInfo.identifier.trim();
      if (identifier.isEmpty) {
        return null;
      }

      final localizedName = timezoneInfo.localizedName?.name.trim();
      return LocationContext(
        timezoneId: identifier,
        utcOffsetSeconds: _offsetForTimezone(identifier),
        city: localizedName != null && localizedName.isNotEmpty
            ? localizedName
            : null,
        source: LocationContextSource.deviceTimezone,
        updatedAt: _now(),
      );
    } on Exception {
      return null;
    }
  }

  LocationContext _fromTimezoneOnly(
    String timezoneId, {
    required LocationContextSource source,
  }) {
    return LocationContext(
      timezoneId: timezoneId,
      utcOffsetSeconds: _offsetForTimezone(timezoneId),
      source: source,
      updatedAt: _now(),
    );
  }

  int _offsetForTimezone(String timezoneId) {
    try {
      if (!_tzInitialized) {
        tz_data.initializeTimeZones();
        _tzInitialized = true;
      }
      final location = tz.getLocation(timezoneId);
      return tz.TZDateTime.now(location).timeZoneOffset.inSeconds;
    } on Object {
      return DateTime.now().timeZoneOffset.inSeconds;
    }
  }

  String _mapLocaleIdentifier(String localeCode) {
    return switch (localeCode) {
      'ar' => 'ar_DZ',
      'fr' => 'fr_FR',
      _ => 'en_US',
    };
  }

  String? _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final normalized = value?.trim();
      if (normalized != null && normalized.isNotEmpty) {
        return normalized;
      }
    }
    return null;
  }

  DateTime _now() => (now ?? DateTime.now).call();
}

class LocationContextStore {
  const LocationContextStore(this._box);

  final Box<String> _box;

  static const modeKey = 'location_mode';
  static const manualTimezoneKey = 'manual_timezone_id';
  static const cacheKey = 'location_context_cache';

  LocationMode readMode() {
    final raw = _box.get(modeKey);
    if (raw == null) {
      return LocationMode.automatic;
    }
    return LocationMode.values.firstWhere(
      (value) => value.name == raw,
      orElse: () => LocationMode.automatic,
    );
  }

  Future<void> writeMode(LocationMode mode) async {
    await _box.put(modeKey, mode.name);
  }

  String? readManualTimezoneId() {
    final value = _box.get(manualTimezoneKey)?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  Future<void> writeManualTimezoneId(String? timezoneId) async {
    final normalized = timezoneId?.trim();
    if (normalized == null || normalized.isEmpty) {
      await _box.delete(manualTimezoneKey);
      return;
    }
    await _box.put(manualTimezoneKey, normalized);
  }

  LocationContext? readCachedContext() {
    final raw = _box.get(cacheKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) {
        return null;
      }
      return LocationContext.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  Future<void> writeCachedContext(LocationContext context) async {
    await _box.put(cacheKey, jsonEncode(context.toJson()));
  }

  bool isCacheFresh(
    LocationContext context, {
    Duration ttl = const Duration(hours: 24),
  }) {
    final age = _effectiveNow().difference(context.updatedAt);
    return age <= ttl;
  }

  DateTime _effectiveNow() => DateTime.now();
}

class GeoPoint {
  const GeoPoint(this.latitude, this.longitude);
  final double latitude;
  final double longitude;
}

class _ResolvedTimezone {
  const _ResolvedTimezone(this.timezoneId, this.utcOffsetSeconds);
  final String timezoneId;
  final int utcOffsetSeconds;
}

class _ResolvedPlace {
  const _ResolvedPlace({this.city, this.country});
  final String? city;
  final String? country;
}
