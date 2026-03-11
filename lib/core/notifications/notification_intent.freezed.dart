// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationIntent {

 int get v; NotificationIntentType get type; String get intentId; PrayerType? get prayerType; String? get dateIso; String? get scheduledAtIso; String? get sourceNotificationId; String? get sentAtIso;
/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<NotificationIntent> get copyWith => _$NotificationIntentCopyWithImpl<NotificationIntent>(this as NotificationIntent, _$identity);

  /// Serializes this NotificationIntent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationIntent&&(identical(other.v, v) || other.v == v)&&(identical(other.type, type) || other.type == type)&&(identical(other.intentId, intentId) || other.intentId == intentId)&&(identical(other.prayerType, prayerType) || other.prayerType == prayerType)&&(identical(other.dateIso, dateIso) || other.dateIso == dateIso)&&(identical(other.scheduledAtIso, scheduledAtIso) || other.scheduledAtIso == scheduledAtIso)&&(identical(other.sourceNotificationId, sourceNotificationId) || other.sourceNotificationId == sourceNotificationId)&&(identical(other.sentAtIso, sentAtIso) || other.sentAtIso == sentAtIso));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,type,intentId,prayerType,dateIso,scheduledAtIso,sourceNotificationId,sentAtIso);

@override
String toString() {
  return 'NotificationIntent(v: $v, type: $type, intentId: $intentId, prayerType: $prayerType, dateIso: $dateIso, scheduledAtIso: $scheduledAtIso, sourceNotificationId: $sourceNotificationId, sentAtIso: $sentAtIso)';
}


}

/// @nodoc
abstract mixin class $NotificationIntentCopyWith<$Res>  {
  factory $NotificationIntentCopyWith(NotificationIntent value, $Res Function(NotificationIntent) _then) = _$NotificationIntentCopyWithImpl;
@useResult
$Res call({
 int v, NotificationIntentType type, String intentId, PrayerType? prayerType, String? dateIso, String? scheduledAtIso, String? sourceNotificationId, String? sentAtIso
});




}
/// @nodoc
class _$NotificationIntentCopyWithImpl<$Res>
    implements $NotificationIntentCopyWith<$Res> {
  _$NotificationIntentCopyWithImpl(this._self, this._then);

  final NotificationIntent _self;
  final $Res Function(NotificationIntent) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? v = null,Object? type = null,Object? intentId = null,Object? prayerType = freezed,Object? dateIso = freezed,Object? scheduledAtIso = freezed,Object? sourceNotificationId = freezed,Object? sentAtIso = freezed,}) {
  return _then(_self.copyWith(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationIntentType,intentId: null == intentId ? _self.intentId : intentId // ignore: cast_nullable_to_non_nullable
as String,prayerType: freezed == prayerType ? _self.prayerType : prayerType // ignore: cast_nullable_to_non_nullable
as PrayerType?,dateIso: freezed == dateIso ? _self.dateIso : dateIso // ignore: cast_nullable_to_non_nullable
as String?,scheduledAtIso: freezed == scheduledAtIso ? _self.scheduledAtIso : scheduledAtIso // ignore: cast_nullable_to_non_nullable
as String?,sourceNotificationId: freezed == sourceNotificationId ? _self.sourceNotificationId : sourceNotificationId // ignore: cast_nullable_to_non_nullable
as String?,sentAtIso: freezed == sentAtIso ? _self.sentAtIso : sentAtIso // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationIntent].
extension NotificationIntentPatterns on NotificationIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationIntent value)  $default,){
final _that = this;
switch (_that) {
case _NotificationIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationIntent value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int v,  NotificationIntentType type,  String intentId,  PrayerType? prayerType,  String? dateIso,  String? scheduledAtIso,  String? sourceNotificationId,  String? sentAtIso)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
return $default(_that.v,_that.type,_that.intentId,_that.prayerType,_that.dateIso,_that.scheduledAtIso,_that.sourceNotificationId,_that.sentAtIso);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int v,  NotificationIntentType type,  String intentId,  PrayerType? prayerType,  String? dateIso,  String? scheduledAtIso,  String? sourceNotificationId,  String? sentAtIso)  $default,) {final _that = this;
switch (_that) {
case _NotificationIntent():
return $default(_that.v,_that.type,_that.intentId,_that.prayerType,_that.dateIso,_that.scheduledAtIso,_that.sourceNotificationId,_that.sentAtIso);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int v,  NotificationIntentType type,  String intentId,  PrayerType? prayerType,  String? dateIso,  String? scheduledAtIso,  String? sourceNotificationId,  String? sentAtIso)?  $default,) {final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
return $default(_that.v,_that.type,_that.intentId,_that.prayerType,_that.dateIso,_that.scheduledAtIso,_that.sourceNotificationId,_that.sentAtIso);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationIntent extends NotificationIntent {
  const _NotificationIntent({required this.v, required this.type, required this.intentId, this.prayerType, this.dateIso, this.scheduledAtIso, this.sourceNotificationId, this.sentAtIso}): super._();
  factory _NotificationIntent.fromJson(Map<String, dynamic> json) => _$NotificationIntentFromJson(json);

@override final  int v;
@override final  NotificationIntentType type;
@override final  String intentId;
@override final  PrayerType? prayerType;
@override final  String? dateIso;
@override final  String? scheduledAtIso;
@override final  String? sourceNotificationId;
@override final  String? sentAtIso;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationIntentCopyWith<_NotificationIntent> get copyWith => __$NotificationIntentCopyWithImpl<_NotificationIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationIntent&&(identical(other.v, v) || other.v == v)&&(identical(other.type, type) || other.type == type)&&(identical(other.intentId, intentId) || other.intentId == intentId)&&(identical(other.prayerType, prayerType) || other.prayerType == prayerType)&&(identical(other.dateIso, dateIso) || other.dateIso == dateIso)&&(identical(other.scheduledAtIso, scheduledAtIso) || other.scheduledAtIso == scheduledAtIso)&&(identical(other.sourceNotificationId, sourceNotificationId) || other.sourceNotificationId == sourceNotificationId)&&(identical(other.sentAtIso, sentAtIso) || other.sentAtIso == sentAtIso));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,type,intentId,prayerType,dateIso,scheduledAtIso,sourceNotificationId,sentAtIso);

@override
String toString() {
  return 'NotificationIntent(v: $v, type: $type, intentId: $intentId, prayerType: $prayerType, dateIso: $dateIso, scheduledAtIso: $scheduledAtIso, sourceNotificationId: $sourceNotificationId, sentAtIso: $sentAtIso)';
}


}

/// @nodoc
abstract mixin class _$NotificationIntentCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$NotificationIntentCopyWith(_NotificationIntent value, $Res Function(_NotificationIntent) _then) = __$NotificationIntentCopyWithImpl;
@override @useResult
$Res call({
 int v, NotificationIntentType type, String intentId, PrayerType? prayerType, String? dateIso, String? scheduledAtIso, String? sourceNotificationId, String? sentAtIso
});




}
/// @nodoc
class __$NotificationIntentCopyWithImpl<$Res>
    implements _$NotificationIntentCopyWith<$Res> {
  __$NotificationIntentCopyWithImpl(this._self, this._then);

  final _NotificationIntent _self;
  final $Res Function(_NotificationIntent) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? v = null,Object? type = null,Object? intentId = null,Object? prayerType = freezed,Object? dateIso = freezed,Object? scheduledAtIso = freezed,Object? sourceNotificationId = freezed,Object? sentAtIso = freezed,}) {
  return _then(_NotificationIntent(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationIntentType,intentId: null == intentId ? _self.intentId : intentId // ignore: cast_nullable_to_non_nullable
as String,prayerType: freezed == prayerType ? _self.prayerType : prayerType // ignore: cast_nullable_to_non_nullable
as PrayerType?,dateIso: freezed == dateIso ? _self.dateIso : dateIso // ignore: cast_nullable_to_non_nullable
as String?,scheduledAtIso: freezed == scheduledAtIso ? _self.scheduledAtIso : scheduledAtIso // ignore: cast_nullable_to_non_nullable
as String?,sourceNotificationId: freezed == sourceNotificationId ? _self.sourceNotificationId : sourceNotificationId // ignore: cast_nullable_to_non_nullable
as String?,sentAtIso: freezed == sentAtIso ? _self.sentAtIso : sentAtIso // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
