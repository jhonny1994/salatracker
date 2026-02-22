class LocationContext {
  const LocationContext({
    required this.timezoneId,
    required this.utcOffsetSeconds,
    required this.source,
    required this.updatedAt,
    this.city,
    this.country,
  });

  factory LocationContext.fromJson(Map<String, dynamic> json) {
    return LocationContext(
      timezoneId: json['timezoneId'] as String? ?? 'UTC',
      utcOffsetSeconds: json['utcOffsetSeconds'] as int? ?? 0,
      city: json['city'] as String?,
      country: json['country'] as String?,
      source: LocationContextSource.values.byName(
        json['source'] as String? ?? LocationContextSource.utcFallback.name,
      ),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  final String timezoneId;
  final int utcOffsetSeconds;
  final String? city;
  final String? country;
  final LocationContextSource source;
  final DateTime updatedAt;

  String get displayLabel {
    final offset = _formatOffset(utcOffsetSeconds);
    final parts = <String>[];
    final cityValue = city?.trim();
    final countryValue = country?.trim();

    if (cityValue != null && cityValue.isNotEmpty) {
      parts.add(cityValue);
    }
    if (countryValue != null && countryValue.isNotEmpty) {
      parts.add(countryValue);
    }

    final title = parts.isEmpty ? timezoneId : parts.join(', ');
    return '$title · $offset';
  }

  Map<String, dynamic> toJson() {
    return {
      'timezoneId': timezoneId,
      'utcOffsetSeconds': utcOffsetSeconds,
      'city': city,
      'country': country,
      'source': source.name,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  LocationContext copyWith({
    String? timezoneId,
    int? utcOffsetSeconds,
    String? city,
    String? country,
    LocationContextSource? source,
    DateTime? updatedAt,
  }) {
    return LocationContext(
      timezoneId: timezoneId ?? this.timezoneId,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      city: city ?? this.city,
      country: country ?? this.country,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static String _formatOffset(int offsetSeconds) {
    final sign = offsetSeconds < 0 ? '-' : '+';
    final absolute = offsetSeconds.abs();
    final hours = (absolute ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((absolute % 3600) ~/ 60).toString().padLeft(2, '0');
    return 'UTC$sign$hours:$minutes';
  }
}

enum LocationContextSource {
  manual,
  gpsApi,
  cache,
  deviceTimezone,
  utcFallback,
}

enum LocationMode {
  automatic,
  manual,
}
