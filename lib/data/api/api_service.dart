import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:k31_storyapp_flutter/models/detail_story_response.dart';
import 'package:k31_storyapp_flutter/models/register_and_add_response.dart';
import 'package:k31_storyapp_flutter/models/login_response.dart';
import 'package:k31_storyapp_flutter/models/stories_response.dart';

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterAndAddStoryResponse> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode.toString().startsWith('2')) {
      return RegisterAndAddStoryResponse.fromJson(json.decode(response.body));
    } else {
      final error = RegisterAndAddStoryResponse.fromJson(
        json.decode(response.body),
      );
      throw Exception('Gagal Register User: ${error.message}');
    }
  }

  Future<LoginResponse> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode.toString().startsWith('2')) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      final error = RegisterAndAddStoryResponse.fromJson(
        json.decode(response.body),
      );
      throw Exception('Gagal Login User: ${error.message}');
    }
  }

  Future<StoriesResponse> getAllStory(
    String token, {
    int? page,
    int limit = 10,
    int? location,
  }) async {
    var urlBuilder = "$baseUrl/stories?size=$limit";
    if (page != null) {
      urlBuilder += "&page=$page";
    }
    if (location != null) {
      urlBuilder += "&location=$location";
    }
    final urlHit = Uri.parse(
      urlBuilder,
    );
    final response = await http.get(
      urlHit,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode.toString().startsWith('2')) {
      return StoriesResponse.fromJson(json.decode(response.body));
    } else {
      final error = RegisterAndAddStoryResponse.fromJson(
        json.decode(response.body),
      );
      throw Exception('Gagal Login User: ${error.message}');
    }
  }

  Future<DetailStoryResponse> getDetailStory(
    String storyId,
    String token,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/stories/$storyId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode.toString().startsWith('2')) {
      return DetailStoryResponse.fromJson(json.decode(response.body));
    } else {
      final error = RegisterAndAddStoryResponse.fromJson(
        json.decode(response.body),
      );
      throw Exception('Gagal Login User: ${error.message}');
    }
  }

  Future<RegisterAndAddStoryResponse> addStory(
    String description,
    List<int> foto,
    String token,
    String fileName,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/stories"),
    );
    request.headers.addAll({
      "Authorization": "Bearer $token",
    });
    request.fields['description'] = description;
    request.files.add(
      http.MultipartFile.fromBytes(
        'photo',
        foto,
        filename: "$token-$fileName",
      ),
    );
    final response = await request.send();
    final responseFromServer = await http.Response.fromStream(response);

    if (response.statusCode == 201) {
      return RegisterAndAddStoryResponse.fromJson(
          json.decode(responseFromServer.body));
    } else {
      final error = RegisterAndAddStoryResponse.fromJson(
        json.decode(responseFromServer.body),
      );
      throw Exception('Gagal Create Story: ${error.message}');
    }
  }
}
