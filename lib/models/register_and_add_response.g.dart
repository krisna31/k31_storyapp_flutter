// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_and_add_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAndAddStoryResponse _$RegisterAndAddStoryResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterAndAddStoryResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RegisterAndAddStoryResponseToJson(
        RegisterAndAddStoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
