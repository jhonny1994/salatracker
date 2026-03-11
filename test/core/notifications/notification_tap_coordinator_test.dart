import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:salat_tracker/core/notifications/notification_entry_intent_store.dart';
import 'package:salat_tracker/core/notifications/notification_intent.dart';
import 'package:salat_tracker/core/notifications/notification_service.dart';
import 'package:salat_tracker/core/notifications/notification_tap_coordinator.dart';
import 'package:salat_tracker/core/storage/hive_service.dart';

void main() {
  late Box<String> box;

  setUpAll(() async {
    Hive.init('.dart_tool/test-hive-notification-coordinator');
    box = await Hive.openBox<String>(HiveService.notificationMetaBoxName);
  });

  tearDown(() async {
    await box.clear();
  });

  test('stores pending intent when payload processed', () async {
    final store = NotificationEntryIntentStore(box);
    final coordinator = NotificationTapCoordinator(
      service: NotificationService(),
      store: store,
    );

    final payload = NotificationIntent.dailyCheckin(
      intentId: 'intent_1',
      scheduledAt: DateTime(2026, 3, 12, 22),
      sourceNotificationId: 99,
    ).toPayload();

    await coordinator.processPayload(payload);

    final pending = store.readPending();
    expect(pending, isNotNull);
    expect(pending!.intentId, 'intent_1');
  });

  test('ignores payload when root intent already handled', () async {
    final store = NotificationEntryIntentStore(box);
    await store.setLastHandledIntentId('intent_1');

    final coordinator = NotificationTapCoordinator(
      service: NotificationService(),
      store: store,
    );

    final payload = NotificationIntent.dailyCheckin(
      intentId: 'intent_1${NotificationIntent.snoozeSeparator}1700000',
      scheduledAt: DateTime(2026, 3, 12, 22),
      sourceNotificationId: 99,
    ).toPayload();

    await coordinator.processPayload(payload);

    expect(store.readPending(), isNull);
  });
}
