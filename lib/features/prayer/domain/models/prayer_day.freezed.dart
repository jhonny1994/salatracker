// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerDay {

@HiveField(0) DateTime get date;@HiveField(1) List<PrayerEntry> get entries;@HiveField(2) bool get isComplete;@HiveField(3) int get points;
/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerDayCopyWith<PrayerDay> get copyWith => _$PrayerDayCopyWithImpl<PrayerDay>(this as PrayerDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerDay&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(entries),isComplete,points);

@override
String toString() {
  return 'PrayerDay(date: $date, entries: $entries, isComplete: $isComplete, points: $points)';
}


}

/// @nodoc
abstract mixin class $PrayerDayCopyWith<$Res>  {
  factory $PrayerDayCopyWith(PrayerDay value, $Res Function(PrayerDay) _then) = _$PrayerDayCopyWithImpl;
@useResult
$Res call({
@HiveField(0) DateTime date,@HiveField(1) List<PrayerEntry> entries,@HiveField(2) bool isComplete,@HiveField(3) int points
});




}
/// @nodoc
class _$PrayerDayCopyWithImpl<$Res>
    implements $PrayerDayCopyWith<$Res> {
  _$PrayerDayCopyWithImpl(this._self, this._then);

  final PrayerDay _self;
  final $Res Function(PrayerDay) _then;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? entries = null,Object? isComplete = null,Object? points = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<PrayerEntry>,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerDay].
extension PrayerDayPatterns on PrayerDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerDay value)  $default,){
final _that = this;
switch (_that) {
case _PrayerDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerDay value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  DateTime date, @HiveField(1)  List<PrayerEntry> entries, @HiveField(2)  bool isComplete, @HiveField(3)  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
return $default(_that.date,_that.entries,_that.isComplete,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  DateTime date, @HiveField(1)  List<PrayerEntry> entries, @HiveField(2)  bool isComplete, @HiveField(3)  int points)  $default,) {final _that = this;
switch (_that) {
case _PrayerDay():
return $default(_that.date,_that.entries,_that.isComplete,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  DateTime date, @HiveField(1)  List<PrayerEntry> entries, @HiveField(2)  bool isComplete, @HiveField(3)  int points)?  $default,) {final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
return $default(_that.date,_that.entries,_that.isComplete,_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerDay implements PrayerDay {
  const _PrayerDay({@HiveField(0) required this.date, @HiveField(1) required final  List<PrayerEntry> entries, @HiveField(2) required this.isComplete, @HiveField(3) required this.points}): _entries = entries;
  

@override@HiveField(0) final  DateTime date;
 final  List<PrayerEntry> _entries;
@override@HiveField(1) List<PrayerEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override@HiveField(2) final  bool isComplete;
@override@HiveField(3) final  int points;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerDayCopyWith<_PrayerDay> get copyWith => __$PrayerDayCopyWithImpl<_PrayerDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerDay&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_entries),isComplete,points);

@override
String toString() {
  return 'PrayerDay(date: $date, entries: $entries, isComplete: $isComplete, points: $points)';
}


}

/// @nodoc
abstract mixin class _$PrayerDayCopyWith<$Res> implements $PrayerDayCopyWith<$Res> {
  factory _$PrayerDayCopyWith(_PrayerDay value, $Res Function(_PrayerDay) _then) = __$PrayerDayCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) DateTime date,@HiveField(1) List<PrayerEntry> entries,@HiveField(2) bool isComplete,@HiveField(3) int points
});




}
/// @nodoc
class __$PrayerDayCopyWithImpl<$Res>
    implements _$PrayerDayCopyWith<$Res> {
  __$PrayerDayCopyWithImpl(this._self, this._then);

  final _PrayerDay _self;
  final $Res Function(_PrayerDay) _then;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? entries = null,Object? isComplete = null,Object? points = null,}) {
  return _then(_PrayerDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<PrayerEntry>,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
