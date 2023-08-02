// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseItem _$LoginResponseItemFromJson(Map<String, dynamic> json) =>
    LoginResponseItem(
      userId: json['userId'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResponseItemToJson(LoginResponseItem instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'token': instance.token,
    };
