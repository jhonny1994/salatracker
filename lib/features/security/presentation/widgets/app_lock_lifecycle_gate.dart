import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// Observes app lifecycle and triggers app lock after background resume.
class AppLockLifecycleGate extends ConsumerStatefulWidget {
  const AppLockLifecycleGate({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppLockLifecycleGate> createState() =>
      _AppLockLifecycleGateState();
}

class _AppLockLifecycleGateState extends ConsumerState<AppLockLifecycleGate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      unawaited(_lockIfNeeded());
    }
  }

  Future<void> _lockIfNeeded() async {
    final settings = await ref.read(settingsProvider.future);
    if (!settings.onboardingComplete || !settings.appLockEnabled) {
      return;
    }

    final repository = ref.read(securityRepositoryProvider);
    final hasPin = await repository.hasPin();
    if (!hasPin) {
      return;
    }

    ref.read(appLockControllerProvider.notifier).lockApp();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
