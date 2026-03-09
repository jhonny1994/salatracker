import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';

/// Location setup page for onboarding.
class LocationPage extends ConsumerStatefulWidget {
  /// Creates a [LocationPage].
  const LocationPage({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  /// Action when user wants to proceed to the next page.
  final VoidCallback onNext;

  /// Action when user wants to go back.
  final VoidCallback onBack;

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  bool _requesting = false;

  Future<void> _requestLocation() async {
    setState(() => _requesting = true);
    try {
      final permission = await Geolocator.requestPermission();
      if (!mounted) {
        return;
      }

      final granted =
          permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
      if (granted) {
        widget.onNext();
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).onboardingLocationPermissionDenied),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _requesting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return OnboardingStepScaffold(
      icon: Icons.location_on_outlined,
      title: l10n.onboardingLocationTitle,
      body: l10n.onboardingLocationBody,
      primaryLabel: l10n.onboardingEnableLocation,
      onPrimary: _requesting ? null : () => unawaited(_requestLocation()),
      backLabel: l10n.onboardingMaybeLater,
      onBack: widget.onNext, // "Maybe Later" also proceeds to the next step
      isBusy: _requesting,
      busyLabel: l10n.generalLoading,
      content: const SizedBox.shrink(),
    );
  }
}
