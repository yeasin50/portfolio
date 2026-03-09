// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetInTouchState {

 ContactRequest get req; String? get error; bool get isLoading; bool get isAlreadySubmited;
/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetInTouchStateCopyWith<GetInTouchState> get copyWith => _$GetInTouchStateCopyWithImpl<GetInTouchState>(this as GetInTouchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetInTouchState&&(identical(other.req, req) || other.req == req)&&(identical(other.error, error) || other.error == error)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isAlreadySubmited, isAlreadySubmited) || other.isAlreadySubmited == isAlreadySubmited));
}


@override
int get hashCode => Object.hash(runtimeType,req,error,isLoading,isAlreadySubmited);

@override
String toString() {
  return 'GetInTouchState(req: $req, error: $error, isLoading: $isLoading, isAlreadySubmited: $isAlreadySubmited)';
}


}

/// @nodoc
abstract mixin class $GetInTouchStateCopyWith<$Res>  {
  factory $GetInTouchStateCopyWith(GetInTouchState value, $Res Function(GetInTouchState) _then) = _$GetInTouchStateCopyWithImpl;
@useResult
$Res call({
 ContactRequest req, String? error, bool isLoading, bool isAlreadySubmited
});


$ContactRequestCopyWith<$Res> get req;

}
/// @nodoc
class _$GetInTouchStateCopyWithImpl<$Res>
    implements $GetInTouchStateCopyWith<$Res> {
  _$GetInTouchStateCopyWithImpl(this._self, this._then);

  final GetInTouchState _self;
  final $Res Function(GetInTouchState) _then;

/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? req = null,Object? error = freezed,Object? isLoading = null,Object? isAlreadySubmited = null,}) {
  return _then(_self.copyWith(
req: null == req ? _self.req : req // ignore: cast_nullable_to_non_nullable
as ContactRequest,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isAlreadySubmited: null == isAlreadySubmited ? _self.isAlreadySubmited : isAlreadySubmited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactRequestCopyWith<$Res> get req {
  
  return $ContactRequestCopyWith<$Res>(_self.req, (value) {
    return _then(_self.copyWith(req: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetInTouchState].
extension GetInTouchStatePatterns on GetInTouchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetInTouchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetInTouchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetInTouchState value)  $default,){
final _that = this;
switch (_that) {
case _GetInTouchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetInTouchState value)?  $default,){
final _that = this;
switch (_that) {
case _GetInTouchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContactRequest req,  String? error,  bool isLoading,  bool isAlreadySubmited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetInTouchState() when $default != null:
return $default(_that.req,_that.error,_that.isLoading,_that.isAlreadySubmited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContactRequest req,  String? error,  bool isLoading,  bool isAlreadySubmited)  $default,) {final _that = this;
switch (_that) {
case _GetInTouchState():
return $default(_that.req,_that.error,_that.isLoading,_that.isAlreadySubmited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContactRequest req,  String? error,  bool isLoading,  bool isAlreadySubmited)?  $default,) {final _that = this;
switch (_that) {
case _GetInTouchState() when $default != null:
return $default(_that.req,_that.error,_that.isLoading,_that.isAlreadySubmited);case _:
  return null;

}
}

}

/// @nodoc


class _GetInTouchState implements GetInTouchState {
  const _GetInTouchState({required this.req, this.error, this.isLoading = false, this.isAlreadySubmited = false});
  

@override final  ContactRequest req;
@override final  String? error;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isAlreadySubmited;

/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetInTouchStateCopyWith<_GetInTouchState> get copyWith => __$GetInTouchStateCopyWithImpl<_GetInTouchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetInTouchState&&(identical(other.req, req) || other.req == req)&&(identical(other.error, error) || other.error == error)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isAlreadySubmited, isAlreadySubmited) || other.isAlreadySubmited == isAlreadySubmited));
}


@override
int get hashCode => Object.hash(runtimeType,req,error,isLoading,isAlreadySubmited);

@override
String toString() {
  return 'GetInTouchState(req: $req, error: $error, isLoading: $isLoading, isAlreadySubmited: $isAlreadySubmited)';
}


}

/// @nodoc
abstract mixin class _$GetInTouchStateCopyWith<$Res> implements $GetInTouchStateCopyWith<$Res> {
  factory _$GetInTouchStateCopyWith(_GetInTouchState value, $Res Function(_GetInTouchState) _then) = __$GetInTouchStateCopyWithImpl;
@override @useResult
$Res call({
 ContactRequest req, String? error, bool isLoading, bool isAlreadySubmited
});


@override $ContactRequestCopyWith<$Res> get req;

}
/// @nodoc
class __$GetInTouchStateCopyWithImpl<$Res>
    implements _$GetInTouchStateCopyWith<$Res> {
  __$GetInTouchStateCopyWithImpl(this._self, this._then);

  final _GetInTouchState _self;
  final $Res Function(_GetInTouchState) _then;

/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? req = null,Object? error = freezed,Object? isLoading = null,Object? isAlreadySubmited = null,}) {
  return _then(_GetInTouchState(
req: null == req ? _self.req : req // ignore: cast_nullable_to_non_nullable
as ContactRequest,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isAlreadySubmited: null == isAlreadySubmited ? _self.isAlreadySubmited : isAlreadySubmited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GetInTouchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactRequestCopyWith<$Res> get req {
  
  return $ContactRequestCopyWith<$Res>(_self.req, (value) {
    return _then(_self.copyWith(req: value));
  });
}
}

// dart format on
