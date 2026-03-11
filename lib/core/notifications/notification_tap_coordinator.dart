import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';

part 'notification_tap_coordinator.g.dart';

@riverpod
NotificationTapCoordinator notificationTapCoordinator(Ref ref) {
  final service = ref.watch(notificationServiceProvider);
  final store = ref.watch(notificationEntryIntentStoreProvider);
  return NotificationTapCoordinator(service: service, store: store);
}

class NotificationTapCoordinator {
  NotificationTapCoordinator({
    required NotificationService service,
    required NotificationEntryIntentStore store,
  }) : _service = service,
       _store = store;

  final NotificationService _service;
  final NotificationEntryIntentStore _store;

  Future<NotificationIntent?> bootstrapLaunchIntent() async {
    final payload = await _service.getLaunchPayload();
    if (payload == null || payload.isEmpty) {
      return null;
    }
    return processPayload(payload);
  }

  Future<NotificationIntent> processPayload(String payload) async {
    final intent = NotificationIntent.fromPayload(payload);
    final lastHandled = _store.readLastHandledIntentId();
    if (lastHandled == intent.rootIntentId) {
      return intent;
    }

    await _store.savePending(intent);
    return intent;
  }
}
