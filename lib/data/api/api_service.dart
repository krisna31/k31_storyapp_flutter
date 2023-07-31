import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:k31_storyapp_flutter/models/detail_story_response.dart';
import 'package:k31_storyapp_flutter/models/general_response.dart';
import 'package:k31_storyapp_flutter/models/login_response.dart';
import 'package:k31_storyapp_flutter/models/stories_response.dart';

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<GeneralResponse> register() async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "name": "string",
        "email": "string",
        "password": "string",
      }),
    );
    if (response.statusCode == 200) {
      return GeneralResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Register User');
    }
  }

  Future<LoginResponse> login() async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": "string",
        "password": "string",
      }),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Login User');
    }
  }

  Future<StoriesResponse> getAllStory(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/stories"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return StoriesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data List Story Gagal Dimuat');
    }
  }

  Future<DetailStoryResponse> getDetailStory(
      String storyId, String token) async {
    final response = await http.get(Uri.parse("$baseUrl/stories/$storyId"));

    if (response.statusCode == 200) {
      return DetailStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data Detail Story Gagal Dimuat');
    }
  }

  // Future<AddReview> addReview(
  //   String keyword,
  //   idRestaurant,
  //   name,
  //   review,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/review"),
  //     headers: {"Content-Type": "application/json"},
  //     body: {
  //       "id": idRestaurant,
  //       "name": name,
  //       "review": review,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return AddReview.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Data Restoran Gagal Dimuat');
  //   }
  // }
}
