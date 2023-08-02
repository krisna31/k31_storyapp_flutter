import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'register_and_add_response.g.dart';

@JsonSerializable()
class RegisterAndAddStoryResponse {
  final bool error;
  final String message;

  RegisterAndAddStoryResponse({
    required this.error,
    required this.message,
  });

  factory RegisterAndAddStoryResponse.fromRawJson(String str) =>
      RegisterAndAddStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterAndAddStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterAndAddStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterAndAddStoryResponseToJson(this);
}
