import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/core/notifications/notification_provider.dart';

/// Listens for notification interaction streams and handles navigation.
///
/// Wraps the root application shell to capture notification clicks globally.
class NotificationListenerWidget extends ConsumerStatefulWidget {
  /// Create a const [NotificationListenerWidget].
  const NotificationListenerWidget({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  @override
  ConsumerState<NotificationListenerWidget> createState() =>
      _NotificationListenerWidgetState();
}

class _NotificationListenerWidgetState
    extends ConsumerState<NotificationListenerWidget> {
  StreamSubscription<String?>? _subscription;

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  void _setupListener() {
    // We defer reading the provider until after build.
    // In initState, we can read providers.
    final service = ref.read(notificationServiceProvider);

    _subscription = service.onNotificationClick.listen((payload) {
      if (payload != null && mounted) {
        _handleNavigation(payload);
      }
    });
  }

  void _handleNavigation(String payload) {
    if (payload == '/today') {
      context.go('/today');
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
