import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/notifications/notification_intent.dart';
import 'package:salat_tracker/core/storage/hive_service.dart';

part 'notification_entry_intent_store.g.dart';

const _pendingIntentKey = 'notification_pending_intent';
const _lastHandledIntentKey = 'notification_last_handled_intent';
const _snoozeByIntentPrefix = 'notification_snooze_';

@riverpod
Box<String> notificationMetaBox(Ref ref) =>
    Hive.box<String>(HiveService.notificationMetaBoxName);

class NotificationEntryIntentStore {
  NotificationEntryIntentStore(this._box);

  final Box<String> _box;

  Future<void> savePending(NotificationIntent intent) async {
    await _box.put(_pendingIntentKey, intent.toPayload());
  }

  NotificationIntent? readPending() {
    final payload = _box.get(_pendingIntentKey);
    if (payload == null || payload.isEmpty) {
      return null;
    }
    return NotificationIntent.fromPayload(payload);
  }

  Future<void> clearPending() async {
    await _box.delete(_pendingIntentKey);
  }

  String? readLastHandledIntentId() => _box.get(_lastHandledIntentKey);

  Future<void> setLastHandledIntentId(String intentId) async {
    await _box.put(_lastHandledIntentKey, intentId);
  }

  Future<void> setSnoozeActive({
    required String intentId,
    required int notificationId,
  }) async {
    await _box.put('$_snoozeByIntentPrefix$intentId', '$notificationId');
  }

  bool hasSnoozeActive(String intentId) {
    final value = _box.get('$_snoozeByIntentPrefix$intentId');
    return value != null && value.isNotEmpty;
  }

  Future<void> clearSnooze(String intentId) async {
    await _box.delete('$_snoozeByIntentPrefix$intentId');
  }
}

@riverpod
NotificationEntryIntentStore notificationEntryIntentStore(Ref ref) {
  final box = ref.watch(notificationMetaBoxProvider);
  return NotificationEntryIntentStore(box);
}
