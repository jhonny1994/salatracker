import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Returns a normalized date (midnight, no time component).
  DateTime get dateOnly => DateTime(year, month, day);

  /// Returns a storage key for this date in YYYY-MM-DD format.
  String get storageKey => '$year-$month-$day';

  /// Checks if this date is the same calendar day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns date in format "Month Day, Year" (e.g., "January 1, 2024").
  String get toFormattedDate {
    final formatted = DateFormat.yMMMMd().format(this);
    return formatted.toWesternDigits;
  }

  /// Returns time in format "h:mm a" (e.g., "5:30 PM").
  String get toFormattedTime {
    return DateFormat.jm().format(this);
  }
}

extension _DigitNormalizationX on String {
  String get toWesternDigits {
    const arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';
    const easternArabicDigits = '۰۱۲۳۴۵۶۷۸۹';

    final buffer = StringBuffer();
    for (final rune in runes) {
      final char = String.fromCharCode(rune);
      final arabicIndex = arabicIndicDigits.indexOf(char);
      if (arabicIndex >= 0) {
        buffer.write(arabicIndex);
        continue;
      }

      final easternArabicIndex = easternArabicDigits.indexOf(char);
      if (easternArabicIndex >= 0) {
        buffer.write(easternArabicIndex);
        continue;
      }

      buffer.write(char);
    }
    return buffer.toString();
  }
}
