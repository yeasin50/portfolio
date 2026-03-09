// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_connect_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContactRequest _$ContactRequestFromJson(Map<String, dynamic> json) =>
    _ContactRequest(
      apiKey: json['api_key'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ContactRequestToJson(_ContactRequest instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'name': instance.name,
      'email': instance.email,
      'subject': instance.subject,
      'message': instance.message,
    };

_ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
    _ContactResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ContactResponseToJson(_ContactResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};
