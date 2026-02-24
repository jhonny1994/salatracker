// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing historical prayer data edits.
///
/// Handles toggling prayer completion for past dates with appropriate
/// warnings and analytics tracking.

@ProviderFor(HistoryController)
final historyControllerProvider = HistoryControllerProvider._();

/// Controller for managing historical prayer data edits.
///
/// Handles toggling prayer completion for past dates with appropriate
/// warnings and analytics tracking.
final class HistoryControllerProvider
    extends $NotifierProvider<HistoryController, void> {
  /// Controller for managing historical prayer data edits.
  ///
  /// Handles toggling prayer completion for past dates with appropriate
  /// warnings and analytics tracking.
  HistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @$internal
  @override
  HistoryController create() => HistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$historyControllerHash() => r'dc7764a63485ad42c04aad1ca827a34720c2458b';

/// Controller for managing historical prayer data edits.
///
/// Handles toggling prayer completion for past dates with appropriate
/// warnings and analytics tracking.

abstract class _$HistoryController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
