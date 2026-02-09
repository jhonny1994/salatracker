import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/features/security/data/providers/security_providers.dart';
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
  bool _wasInBackground = false;

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
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _wasInBackground = true;
      return;
    }

    if (state == AppLifecycleState.resumed && _wasInBackground) {
      _wasInBackground = false;
      unawaited(_lockIfNeededAfterResume());
    }
  }

  Future<void> _lockIfNeededAfterResume() async {
    final settings = ref.read(settingsProvider).asData?.value;
    if (settings == null ||
        !settings.onboardingComplete ||
        !settings.appLockEnabled) {
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
