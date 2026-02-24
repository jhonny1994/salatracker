// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Settings {

@HiveField(0) Map<PrayerType, TimeOfDay> get prayerTimes;@HiveField(1) Map<PrayerType, int> get offsets;@HiveField(2) bool get notificationsEnabled;@HiveField(3) bool get hapticsEnabled;@HiveField(5) AppThemeMode get themeMode;@HiveField(6) String? get localeCode;@HiveField(7) int get weekStart;@HiveField(8) bool get onboardingComplete;@HiveField(9) bool get appLockEnabled;@HiveField(10) bool get biometricUnlockEnabled;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&const DeepCollectionEquality().equals(other.prayerTimes, prayerTimes)&&const DeepCollectionEquality().equals(other.offsets, offsets)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.hapticsEnabled, hapticsEnabled) || other.hapticsEnabled == hapticsEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.appLockEnabled, appLockEnabled) || other.appLockEnabled == appLockEnabled)&&(identical(other.biometricUnlockEnabled, biometricUnlockEnabled) || other.biometricUnlockEnabled == biometricUnlockEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(prayerTimes),const DeepCollectionEquality().hash(offsets),notificationsEnabled,hapticsEnabled,themeMode,localeCode,weekStart,onboardingComplete,appLockEnabled,biometricUnlockEnabled);

@override
String toString() {
  return 'Settings(prayerTimes: $prayerTimes, offsets: $offsets, notificationsEnabled: $notificationsEnabled, hapticsEnabled: $hapticsEnabled, themeMode: $themeMode, localeCode: $localeCode, weekStart: $weekStart, onboardingComplete: $onboardingComplete, appLockEnabled: $appLockEnabled, biometricUnlockEnabled: $biometricUnlockEnabled)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
@HiveField(0) Map<PrayerType, TimeOfDay> prayerTimes,@HiveField(1) Map<PrayerType, int> offsets,@HiveField(2) bool notificationsEnabled,@HiveField(3) bool hapticsEnabled,@HiveField(5) AppThemeMode themeMode,@HiveField(6) String? localeCode,@HiveField(7) int weekStart,@HiveField(8) bool onboardingComplete,@HiveField(9) bool appLockEnabled,@HiveField(10) bool biometricUnlockEnabled
});




}
/// @nodoc
class _$SettingsCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._self, this._then);

  final Settings _self;
  final $Res Function(Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prayerTimes = null,Object? offsets = null,Object? notificationsEnabled = null,Object? hapticsEnabled = null,Object? themeMode = null,Object? localeCode = freezed,Object? weekStart = null,Object? onboardingComplete = null,Object? appLockEnabled = null,Object? biometricUnlockEnabled = null,}) {
  return _then(_self.copyWith(
prayerTimes: null == prayerTimes ? _self.prayerTimes : prayerTimes // ignore: cast_nullable_to_non_nullable
as Map<PrayerType, TimeOfDay>,offsets: null == offsets ? _self.offsets : offsets // ignore: cast_nullable_to_non_nullable
as Map<PrayerType, int>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,hapticsEnabled: null == hapticsEnabled ? _self.hapticsEnabled : hapticsEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as int,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,appLockEnabled: null == appLockEnabled ? _self.appLockEnabled : appLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,biometricUnlockEnabled: null == biometricUnlockEnabled ? _self.biometricUnlockEnabled : biometricUnlockEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Settings].
extension SettingsPatterns on Settings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settings value)  $default,){
final _that = this;
switch (_that) {
case _Settings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settings value)?  $default,){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  Map<PrayerType, TimeOfDay> prayerTimes, @HiveField(1)  Map<PrayerType, int> offsets, @HiveField(2)  bool notificationsEnabled, @HiveField(3)  bool hapticsEnabled, @HiveField(5)  AppThemeMode themeMode, @HiveField(6)  String? localeCode, @HiveField(7)  int weekStart, @HiveField(8)  bool onboardingComplete, @HiveField(9)  bool appLockEnabled, @HiveField(10)  bool biometricUnlockEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.prayerTimes,_that.offsets,_that.notificationsEnabled,_that.hapticsEnabled,_that.themeMode,_that.localeCode,_that.weekStart,_that.onboardingComplete,_that.appLockEnabled,_that.biometricUnlockEnabled);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  Map<PrayerType, TimeOfDay> prayerTimes, @HiveField(1)  Map<PrayerType, int> offsets, @HiveField(2)  bool notificationsEnabled, @HiveField(3)  bool hapticsEnabled, @HiveField(5)  AppThemeMode themeMode, @HiveField(6)  String? localeCode, @HiveField(7)  int weekStart, @HiveField(8)  bool onboardingComplete, @HiveField(9)  bool appLockEnabled, @HiveField(10)  bool biometricUnlockEnabled)  $default,) {final _that = this;
switch (_that) {
case _Settings():
return $default(_that.prayerTimes,_that.offsets,_that.notificationsEnabled,_that.hapticsEnabled,_that.themeMode,_that.localeCode,_that.weekStart,_that.onboardingComplete,_that.appLockEnabled,_that.biometricUnlockEnabled);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  Map<PrayerType, TimeOfDay> prayerTimes, @HiveField(1)  Map<PrayerType, int> offsets, @HiveField(2)  bool notificationsEnabled, @HiveField(3)  bool hapticsEnabled, @HiveField(5)  AppThemeMode themeMode, @HiveField(6)  String? localeCode, @HiveField(7)  int weekStart, @HiveField(8)  bool onboardingComplete, @HiveField(9)  bool appLockEnabled, @HiveField(10)  bool biometricUnlockEnabled)?  $default,) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.prayerTimes,_that.offsets,_that.notificationsEnabled,_that.hapticsEnabled,_that.themeMode,_that.localeCode,_that.weekStart,_that.onboardingComplete,_that.appLockEnabled,_that.biometricUnlockEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _Settings implements Settings {
  const _Settings({@HiveField(0) required final  Map<PrayerType, TimeOfDay> prayerTimes, @HiveField(1) required final  Map<PrayerType, int> offsets, @HiveField(2) required this.notificationsEnabled, @HiveField(3) required this.hapticsEnabled, @HiveField(5) required this.themeMode, @HiveField(6) required this.localeCode, @HiveField(7) required this.weekStart, @HiveField(8) required this.onboardingComplete, @HiveField(9) required this.appLockEnabled, @HiveField(10) required this.biometricUnlockEnabled}): _prayerTimes = prayerTimes,_offsets = offsets;
  

 final  Map<PrayerType, TimeOfDay> _prayerTimes;
@override@HiveField(0) Map<PrayerType, TimeOfDay> get prayerTimes {
  if (_prayerTimes is EqualUnmodifiableMapView) return _prayerTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_prayerTimes);
}

 final  Map<PrayerType, int> _offsets;
@override@HiveField(1) Map<PrayerType, int> get offsets {
  if (_offsets is EqualUnmodifiableMapView) return _offsets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_offsets);
}

@override@HiveField(2) final  bool notificationsEnabled;
@override@HiveField(3) final  bool hapticsEnabled;
@override@HiveField(5) final  AppThemeMode themeMode;
@override@HiveField(6) final  String? localeCode;
@override@HiveField(7) final  int weekStart;
@override@HiveField(8) final  bool onboardingComplete;
@override@HiveField(9) final  bool appLockEnabled;
@override@HiveField(10) final  bool biometricUnlockEnabled;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&const DeepCollectionEquality().equals(other._prayerTimes, _prayerTimes)&&const DeepCollectionEquality().equals(other._offsets, _offsets)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.hapticsEnabled, hapticsEnabled) || other.hapticsEnabled == hapticsEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.appLockEnabled, appLockEnabled) || other.appLockEnabled == appLockEnabled)&&(identical(other.biometricUnlockEnabled, biometricUnlockEnabled) || other.biometricUnlockEnabled == biometricUnlockEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_prayerTimes),const DeepCollectionEquality().hash(_offsets),notificationsEnabled,hapticsEnabled,themeMode,localeCode,weekStart,onboardingComplete,appLockEnabled,biometricUnlockEnabled);

@override
String toString() {
  return 'Settings(prayerTimes: $prayerTimes, offsets: $offsets, notificationsEnabled: $notificationsEnabled, hapticsEnabled: $hapticsEnabled, themeMode: $themeMode, localeCode: $localeCode, weekStart: $weekStart, onboardingComplete: $onboardingComplete, appLockEnabled: $appLockEnabled, biometricUnlockEnabled: $biometricUnlockEnabled)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) Map<PrayerType, TimeOfDay> prayerTimes,@HiveField(1) Map<PrayerType, int> offsets,@HiveField(2) bool notificationsEnabled,@HiveField(3) bool hapticsEnabled,@HiveField(5) AppThemeMode themeMode,@HiveField(6) String? localeCode,@HiveField(7) int weekStart,@HiveField(8) bool onboardingComplete,@HiveField(9) bool appLockEnabled,@HiveField(10) bool biometricUnlockEnabled
});




}
/// @nodoc
class __$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(this._self, this._then);

  final _Settings _self;
  final $Res Function(_Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prayerTimes = null,Object? offsets = null,Object? notificationsEnabled = null,Object? hapticsEnabled = null,Object? themeMode = null,Object? localeCode = freezed,Object? weekStart = null,Object? onboardingComplete = null,Object? appLockEnabled = null,Object? biometricUnlockEnabled = null,}) {
  return _then(_Settings(
prayerTimes: null == prayerTimes ? _self._prayerTimes : prayerTimes // ignore: cast_nullable_to_non_nullable
as Map<PrayerType, TimeOfDay>,offsets: null == offsets ? _self._offsets : offsets // ignore: cast_nullable_to_non_nullable
as Map<PrayerType, int>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,hapticsEnabled: null == hapticsEnabled ? _self.hapticsEnabled : hapticsEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as int,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,appLockEnabled: null == appLockEnabled ? _self.appLockEnabled : appLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,biometricUnlockEnabled: null == biometricUnlockEnabled ? _self.biometricUnlockEnabled : biometricUnlockEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
