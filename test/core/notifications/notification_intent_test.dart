import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/notifications/notification_intent.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  group('NotificationIntent', () {
    test('round-trips prayer payload', () {
      final intent = NotificationIntent.prayer(
        intentId: 'abc',
        prayerType: PrayerType.fajr,
        date: DateTime(2026, 3, 12),
        scheduledAt: DateTime(2026, 3, 12, 5, 20),
        sourceNotificationId: 42,
      );

      final payload = intent.toPayload();
      final parsed = NotificationIntent.fromPayload(payload);

      expect(parsed.type, NotificationIntentType.prayerReminder);
      expect(parsed.prayerType, PrayerType.fajr);
      expect(parsed.intentId, 'abc');
    });

    test('falls back for invalid payload', () {
      final parsed = NotificationIntent.fromPayload('{invalid json');
      expect(parsed.type, NotificationIntentType.genericFallback);
    });

    test('supports required update and badge payloads', () {
      final requiredUpdate = NotificationIntent.requiredUpdate(
        intentId: 'update_1',
        sourceNotificationId: 11,
      );
      final badgeUnlocked = NotificationIntent.badgeUnlocked(
        intentId: 'badge_1',
        sourceNotificationId: 12,
      );

      final parsedUpdate = NotificationIntent.fromPayload(
        requiredUpdate.toPayload(),
      );
      final parsedBadge = NotificationIntent.fromPayload(
        badgeUnlocked.toPayload(),
      );

      expect(parsedUpdate.type, NotificationIntentType.requiredUpdate);
      expect(parsedBadge.type, NotificationIntentType.badgeUnlocked);
    });

    test('extracts root intent id from snoozed id', () {
      final intent = NotificationIntent.prayer(
        intentId:
            'prayer_fajr_0_2026-03-12T05:20:00.000'
            '${NotificationIntent.snoozeSeparator}1700000000',
        prayerType: PrayerType.fajr,
        date: DateTime(2026, 3, 12),
        scheduledAt: DateTime(2026, 3, 12, 5, 20),
        sourceNotificationId: 42,
      );

      expect(intent.rootIntentId, 'prayer_fajr_0_2026-03-12T05:20:00.000');
    });
  });
}
