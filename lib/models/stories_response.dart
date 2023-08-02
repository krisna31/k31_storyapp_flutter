import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:k31_storyapp_flutter/models/story.dart';

part 'stories_response.g.dart';

@JsonSerializable()
class StoriesResponse {
  final bool error;
  final String message;
  @JsonKey(name: "listStory")
  final List<Story> listStory;

  StoriesResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoriesResponse.fromRawJson(String str) =>
      StoriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$StoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesResponseToJson(this);
}
