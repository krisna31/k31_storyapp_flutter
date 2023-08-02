import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_response_item.g.dart';

@JsonSerializable()
class LoginResponseItem {
  final String userId;
  final String name;
  final String token;

  LoginResponseItem({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResponseItem.fromRawJson(String str) =>
      LoginResponseItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseItem.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseItemToJson(this);
}
