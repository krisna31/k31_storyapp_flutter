import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:k31_storyapp_flutter/models/story.dart';

part 'detail_story_response.g.dart';

@JsonSerializable()
class DetailStoryResponse {
  final bool error;
  final String message;
  final Story story;

  DetailStoryResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryResponse.fromRawJson(String str) =>
      DetailStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailStoryResponseToJson(this);
}
