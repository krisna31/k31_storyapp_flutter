import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'login_response_item.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool error;
  final String message;
  final LoginResponseItem loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
