import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'general_response.g.dart';

@JsonSerializable()
class GeneralResponse {
  final bool error;
  final String message;

  GeneralResponse({
    required this.error,
    required this.message,
  });

  factory GeneralResponse.fromRawJson(String str) =>
      GeneralResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);
}
