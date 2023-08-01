import 'dart:convert';

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
      RegisterAndAddStoryResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
