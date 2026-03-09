// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'i_connect_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactRequest {

 String get apiKey; String get name; String get email; String get subject; String get message;
/// Create a copy of ContactRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactRequestCopyWith<ContactRequest> get copyWith => _$ContactRequestCopyWithImpl<ContactRequest>(this as ContactRequest, _$identity);

  /// Serializes this ContactRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactRequest&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,name,email,subject,message);

@override
String toString() {
  return 'ContactRequest(apiKey: $apiKey, name: $name, email: $email, subject: $subject, message: $message)';
}


}

/// @nodoc
abstract mixin class $ContactRequestCopyWith<$Res>  {
  factory $ContactRequestCopyWith(ContactRequest value, $Res Function(ContactRequest) _then) = _$ContactRequestCopyWithImpl;
@useResult
$Res call({
 String apiKey, String name, String email, String subject, String message
});




}
/// @nodoc
class _$ContactRequestCopyWithImpl<$Res>
    implements $ContactRequestCopyWith<$Res> {
  _$ContactRequestCopyWithImpl(this._self, this._then);

  final ContactRequest _self;
  final $Res Function(ContactRequest) _then;

/// Create a copy of ContactRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiKey = null,Object? name = null,Object? email = null,Object? subject = null,Object? message = null,}) {
  return _then(_self.copyWith(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactRequest].
extension ContactRequestPatterns on ContactRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactRequest value)  $default,){
final _that = this;
switch (_that) {
case _ContactRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ContactRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String apiKey,  String name,  String email,  String subject,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactRequest() when $default != null:
return $default(_that.apiKey,_that.name,_that.email,_that.subject,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String apiKey,  String name,  String email,  String subject,  String message)  $default,) {final _that = this;
switch (_that) {
case _ContactRequest():
return $default(_that.apiKey,_that.name,_that.email,_that.subject,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String apiKey,  String name,  String email,  String subject,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ContactRequest() when $default != null:
return $default(_that.apiKey,_that.name,_that.email,_that.subject,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactRequest extends ContactRequest {
  const _ContactRequest({required this.apiKey, required this.name, required this.email, required this.subject, required this.message}): super._();
  factory _ContactRequest.fromJson(Map<String, dynamic> json) => _$ContactRequestFromJson(json);

@override final  String apiKey;
@override final  String name;
@override final  String email;
@override final  String subject;
@override final  String message;

/// Create a copy of ContactRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactRequestCopyWith<_ContactRequest> get copyWith => __$ContactRequestCopyWithImpl<_ContactRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactRequest&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,name,email,subject,message);

@override
String toString() {
  return 'ContactRequest(apiKey: $apiKey, name: $name, email: $email, subject: $subject, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ContactRequestCopyWith<$Res> implements $ContactRequestCopyWith<$Res> {
  factory _$ContactRequestCopyWith(_ContactRequest value, $Res Function(_ContactRequest) _then) = __$ContactRequestCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String name, String email, String subject, String message
});




}
/// @nodoc
class __$ContactRequestCopyWithImpl<$Res>
    implements _$ContactRequestCopyWith<$Res> {
  __$ContactRequestCopyWithImpl(this._self, this._then);

  final _ContactRequest _self;
  final $Res Function(_ContactRequest) _then;

/// Create a copy of ContactRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? name = null,Object? email = null,Object? subject = null,Object? message = null,}) {
  return _then(_ContactRequest(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ContactResponse {

 bool get success; String? get message;
/// Create a copy of ContactResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactResponseCopyWith<ContactResponse> get copyWith => _$ContactResponseCopyWithImpl<ContactResponse>(this as ContactResponse, _$identity);

  /// Serializes this ContactResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ContactResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $ContactResponseCopyWith<$Res>  {
  factory $ContactResponseCopyWith(ContactResponse value, $Res Function(ContactResponse) _then) = _$ContactResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message
});




}
/// @nodoc
class _$ContactResponseCopyWithImpl<$Res>
    implements $ContactResponseCopyWith<$Res> {
  _$ContactResponseCopyWithImpl(this._self, this._then);

  final ContactResponse _self;
  final $Res Function(ContactResponse) _then;

/// Create a copy of ContactResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactResponse].
extension ContactResponsePatterns on ContactResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactResponse value)  $default,){
final _that = this;
switch (_that) {
case _ContactResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ContactResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactResponse() when $default != null:
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ContactResponse():
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ContactResponse() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactResponse implements ContactResponse {
  const _ContactResponse({required this.success, this.message});
  factory _ContactResponse.fromJson(Map<String, dynamic> json) => _$ContactResponseFromJson(json);

@override final  bool success;
@override final  String? message;

/// Create a copy of ContactResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactResponseCopyWith<_ContactResponse> get copyWith => __$ContactResponseCopyWithImpl<_ContactResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ContactResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ContactResponseCopyWith<$Res> implements $ContactResponseCopyWith<$Res> {
  factory _$ContactResponseCopyWith(_ContactResponse value, $Res Function(_ContactResponse) _then) = __$ContactResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message
});




}
/// @nodoc
class __$ContactResponseCopyWithImpl<$Res>
    implements _$ContactResponseCopyWith<$Res> {
  __$ContactResponseCopyWithImpl(this._self, this._then);

  final _ContactResponse _self;
  final $Res Function(_ContactResponse) _then;

/// Create a copy of ContactResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,}) {
  return _then(_ContactResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
