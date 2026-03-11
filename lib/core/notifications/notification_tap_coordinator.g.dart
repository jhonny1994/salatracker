// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_tap_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationTapCoordinator)
final notificationTapCoordinatorProvider =
    NotificationTapCoordinatorProvider._();

final class NotificationTapCoordinatorProvider
    extends
        $FunctionalProvider<
          NotificationTapCoordinator,
          NotificationTapCoordinator,
          NotificationTapCoordinator
        >
    with $Provider<NotificationTapCoordinator> {
  NotificationTapCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationTapCoordinatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationTapCoordinatorHash();

  @$internal
  @override
  $ProviderElement<NotificationTapCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationTapCoordinator create(Ref ref) {
    return notificationTapCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationTapCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationTapCoordinator>(value),
    );
  }
}

String _$notificationTapCoordinatorHash() =>
    r'b26757b979ca26aaa9c625b3f8473d6729eab200';
