// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_reminder_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyReminderConfig {

@HiveField(0) int get id;@HiveField(1) TimeOfDay get time;@HiveField(2) bool get enabled;
/// Create a copy of DailyReminderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReminderConfigCopyWith<DailyReminderConfig> get copyWith => _$DailyReminderConfigCopyWithImpl<DailyReminderConfig>(this as DailyReminderConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReminderConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,id,time,enabled);

@override
String toString() {
  return 'DailyReminderConfig(id: $id, time: $time, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $DailyReminderConfigCopyWith<$Res>  {
  factory $DailyReminderConfigCopyWith(DailyReminderConfig value, $Res Function(DailyReminderConfig) _then) = _$DailyReminderConfigCopyWithImpl;
@useResult
$Res call({
@HiveField(0) int id,@HiveField(1) TimeOfDay time,@HiveField(2) bool enabled
});




}
/// @nodoc
class _$DailyReminderConfigCopyWithImpl<$Res>
    implements $DailyReminderConfigCopyWith<$Res> {
  _$DailyReminderConfigCopyWithImpl(this._self, this._then);

  final DailyReminderConfig _self;
  final $Res Function(DailyReminderConfig) _then;

/// Create a copy of DailyReminderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? time = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReminderConfig].
extension DailyReminderConfigPatterns on DailyReminderConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReminderConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReminderConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReminderConfig value)  $default,){
final _that = this;
switch (_that) {
case _DailyReminderConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReminderConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReminderConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  int id, @HiveField(1)  TimeOfDay time, @HiveField(2)  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReminderConfig() when $default != null:
return $default(_that.id,_that.time,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  int id, @HiveField(1)  TimeOfDay time, @HiveField(2)  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _DailyReminderConfig():
return $default(_that.id,_that.time,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  int id, @HiveField(1)  TimeOfDay time, @HiveField(2)  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _DailyReminderConfig() when $default != null:
return $default(_that.id,_that.time,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _DailyReminderConfig extends DailyReminderConfig {
  const _DailyReminderConfig({@HiveField(0) required this.id, @HiveField(1) required this.time, @HiveField(2) required this.enabled}): super._();
  

@override@HiveField(0) final  int id;
@override@HiveField(1) final  TimeOfDay time;
@override@HiveField(2) final  bool enabled;

/// Create a copy of DailyReminderConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReminderConfigCopyWith<_DailyReminderConfig> get copyWith => __$DailyReminderConfigCopyWithImpl<_DailyReminderConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReminderConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,id,time,enabled);

@override
String toString() {
  return 'DailyReminderConfig(id: $id, time: $time, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$DailyReminderConfigCopyWith<$Res> implements $DailyReminderConfigCopyWith<$Res> {
  factory _$DailyReminderConfigCopyWith(_DailyReminderConfig value, $Res Function(_DailyReminderConfig) _then) = __$DailyReminderConfigCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) int id,@HiveField(1) TimeOfDay time,@HiveField(2) bool enabled
});




}
/// @nodoc
class __$DailyReminderConfigCopyWithImpl<$Res>
    implements _$DailyReminderConfigCopyWith<$Res> {
  __$DailyReminderConfigCopyWithImpl(this._self, this._then);

  final _DailyReminderConfig _self;
  final $Res Function(_DailyReminderConfig) _then;

/// Create a copy of DailyReminderConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? time = null,Object? enabled = null,}) {
  return _then(_DailyReminderConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
