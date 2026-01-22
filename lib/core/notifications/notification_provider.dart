import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/notifications/notification_service.dart';

part 'notification_provider.g.dart';

/// Provider for the app-wide notification service.
@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  return NotificationService();
}
