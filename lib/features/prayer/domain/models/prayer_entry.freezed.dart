// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerEntry {

@HiveField(0) PrayerType get type;@HiveField(1) DateTime get scheduledAt;@HiveField(2) bool get isCompleted;@HiveField(3) DateTime? get checkedAt;
/// Create a copy of PrayerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerEntryCopyWith<PrayerEntry> get copyWith => _$PrayerEntryCopyWithImpl<PrayerEntry>(this as PrayerEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt));
}


@override
int get hashCode => Object.hash(runtimeType,type,scheduledAt,isCompleted,checkedAt);

@override
String toString() {
  return 'PrayerEntry(type: $type, scheduledAt: $scheduledAt, isCompleted: $isCompleted, checkedAt: $checkedAt)';
}


}

/// @nodoc
abstract mixin class $PrayerEntryCopyWith<$Res>  {
  factory $PrayerEntryCopyWith(PrayerEntry value, $Res Function(PrayerEntry) _then) = _$PrayerEntryCopyWithImpl;
@useResult
$Res call({
@HiveField(0) PrayerType type,@HiveField(1) DateTime scheduledAt,@HiveField(2) bool isCompleted,@HiveField(3) DateTime? checkedAt
});




}
/// @nodoc
class _$PrayerEntryCopyWithImpl<$Res>
    implements $PrayerEntryCopyWith<$Res> {
  _$PrayerEntryCopyWithImpl(this._self, this._then);

  final PrayerEntry _self;
  final $Res Function(PrayerEntry) _then;

/// Create a copy of PrayerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? scheduledAt = null,Object? isCompleted = null,Object? checkedAt = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PrayerType,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerEntry].
extension PrayerEntryPatterns on PrayerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerEntry value)  $default,){
final _that = this;
switch (_that) {
case _PrayerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  PrayerType type, @HiveField(1)  DateTime scheduledAt, @HiveField(2)  bool isCompleted, @HiveField(3)  DateTime? checkedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerEntry() when $default != null:
return $default(_that.type,_that.scheduledAt,_that.isCompleted,_that.checkedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  PrayerType type, @HiveField(1)  DateTime scheduledAt, @HiveField(2)  bool isCompleted, @HiveField(3)  DateTime? checkedAt)  $default,) {final _that = this;
switch (_that) {
case _PrayerEntry():
return $default(_that.type,_that.scheduledAt,_that.isCompleted,_that.checkedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  PrayerType type, @HiveField(1)  DateTime scheduledAt, @HiveField(2)  bool isCompleted, @HiveField(3)  DateTime? checkedAt)?  $default,) {final _that = this;
switch (_that) {
case _PrayerEntry() when $default != null:
return $default(_that.type,_that.scheduledAt,_that.isCompleted,_that.checkedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerEntry implements PrayerEntry {
  const _PrayerEntry({@HiveField(0) required this.type, @HiveField(1) required this.scheduledAt, @HiveField(2) required this.isCompleted, @HiveField(3) this.checkedAt});
  

@override@HiveField(0) final  PrayerType type;
@override@HiveField(1) final  DateTime scheduledAt;
@override@HiveField(2) final  bool isCompleted;
@override@HiveField(3) final  DateTime? checkedAt;

/// Create a copy of PrayerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerEntryCopyWith<_PrayerEntry> get copyWith => __$PrayerEntryCopyWithImpl<_PrayerEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt));
}


@override
int get hashCode => Object.hash(runtimeType,type,scheduledAt,isCompleted,checkedAt);

@override
String toString() {
  return 'PrayerEntry(type: $type, scheduledAt: $scheduledAt, isCompleted: $isCompleted, checkedAt: $checkedAt)';
}


}

/// @nodoc
abstract mixin class _$PrayerEntryCopyWith<$Res> implements $PrayerEntryCopyWith<$Res> {
  factory _$PrayerEntryCopyWith(_PrayerEntry value, $Res Function(_PrayerEntry) _then) = __$PrayerEntryCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) PrayerType type,@HiveField(1) DateTime scheduledAt,@HiveField(2) bool isCompleted,@HiveField(3) DateTime? checkedAt
});




}
/// @nodoc
class __$PrayerEntryCopyWithImpl<$Res>
    implements _$PrayerEntryCopyWith<$Res> {
  __$PrayerEntryCopyWithImpl(this._self, this._then);

  final _PrayerEntry _self;
  final $Res Function(_PrayerEntry) _then;

/// Create a copy of PrayerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? scheduledAt = null,Object? isCompleted = null,Object? checkedAt = freezed,}) {
  return _then(_PrayerEntry(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PrayerType,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
