import 'package:flutter/material.dart';
import 'package:k31_storyapp_flutter/data/api/api_service.dart';
import 'package:k31_storyapp_flutter/data/preferences/preference_helper.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';
import 'package:k31_storyapp_flutter/models/detail_story_response.dart';
import 'package:k31_storyapp_flutter/models/stories_response.dart';

class StoryProvider extends ChangeNotifier {
  final PreferencesHelper preferenceHelper;
  final ApiService apiService;

  StoryProvider({
    required this.preferenceHelper,
    required this.apiService,
  }) {
    getAllStory();
  }

  List<ListStory> _stories = [];
  Story _detailStory = Story(
    id: '',
    name: '',
    description: '',
    createdAt: DateTime(123),
    photoUrl: '',
  );
  String _message = '';
  ResState _state = ResState.initial;

  ResState get state => _state;
  String get message => _message;
  List<ListStory> get stories => _stories;
  Story get detailStory => _detailStory;

  void getAllStory() async {
    try {
      _state = ResState.loading;
      final stories =
          await apiService.getAllStory(await preferenceHelper.getToken);
      if (stories.listStory.isEmpty) {
        _state = ResState.noData;
        _message = 'Empty data';
      } else {
        _state = ResState.hasData;
        _stories = stories.listStory;
      }
      notifyListeners();
    } catch (e) {
      _state = ResState.error;
      _message = 'Get Data Story Gagal , $e';
      notifyListeners();
    }
  }

  void getDetailStory(String id) async {
    try {
      _state = ResState.loading;
      notifyListeners();
      final detailStory = await apiService.getDetailStory(
        id,
        await preferenceHelper.getToken,
      );
      _state = ResState.hasData;
      _detailStory = detailStory.story;
      notifyListeners();
    } catch (e) {
      _state = ResState.error;
      _message = 'Get Data Detail Story Gagal , $e';
      notifyListeners();
    }
  }

  // void addStory()
}
