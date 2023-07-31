import 'dart:convert';

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
      GeneralResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
