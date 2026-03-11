// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entry_intent_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationMetaBox)
final notificationMetaBoxProvider = NotificationMetaBoxProvider._();

final class NotificationMetaBoxProvider
    extends $FunctionalProvider<Box<String>, Box<String>, Box<String>>
    with $Provider<Box<String>> {
  NotificationMetaBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationMetaBoxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationMetaBoxHash();

  @$internal
  @override
  $ProviderElement<Box<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<String> create(Ref ref) {
    return notificationMetaBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<String>>(value),
    );
  }
}

String _$notificationMetaBoxHash() =>
    r'f049ab40c95343e57ca0316e303648ec91102f6d';

@ProviderFor(notificationEntryIntentStore)
final notificationEntryIntentStoreProvider =
    NotificationEntryIntentStoreProvider._();

final class NotificationEntryIntentStoreProvider
    extends
        $FunctionalProvider<
          NotificationEntryIntentStore,
          NotificationEntryIntentStore,
          NotificationEntryIntentStore
        >
    with $Provider<NotificationEntryIntentStore> {
  NotificationEntryIntentStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationEntryIntentStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationEntryIntentStoreHash();

  @$internal
  @override
  $ProviderElement<NotificationEntryIntentStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationEntryIntentStore create(Ref ref) {
    return notificationEntryIntentStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationEntryIntentStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationEntryIntentStore>(value),
    );
  }
}

String _$notificationEntryIntentStoreHash() =>
    r'10f204be8fde95011c37ca381a429d1f471a4aff';
