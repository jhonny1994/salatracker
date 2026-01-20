/// Date utilities for consistent date handling across the app.
extension DateTimeX on DateTime {
  /// Returns a normalized date (midnight, no time component).
  DateTime get dateOnly => DateTime(year, month, day);

  /// Returns a storage key for this date in YYYY-MM-DD format.
  String get storageKey => '$year-$month-$day';

  /// Checks if this date is the same calendar day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
