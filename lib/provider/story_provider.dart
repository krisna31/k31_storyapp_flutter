import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:k31_storyapp_flutter/data/api/api_service.dart';
import 'package:k31_storyapp_flutter/data/preferences/preference_helper.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';
import 'package:k31_storyapp_flutter/models/register_and_add_response.dart';

import '../models/story.dart';

class StoryProvider extends ChangeNotifier {
  final PreferencesHelper preferenceHelper;
  final ApiService apiService;
  String? imagePath;
  XFile? imageFile;

  StoryProvider({
    required this.preferenceHelper,
    required this.apiService,
  }) {
    getAllStory();
  }

  List<Story> _stories = [];
  Story _detailStory = Story(
    id: '',
    name: '',
    description: '',
    createdAt: DateTime(123),
    photoUrl: '',
  );
  RegisterAndAddStoryResponse? _addStoryResponse = RegisterAndAddStoryResponse(
    error: false,
    message: '',
  );
  String _message = '';
  ResState _state = ResState.initial;

  ResState get state => _state;
  String get message => _message;
  List<Story> get stories => _stories;
  Story get detailStory => _detailStory;
  RegisterAndAddStoryResponse? get addStoryResponse => _addStoryResponse;

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

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> addStory(
    String description,
    List<int> foto,
    String fileName,
  ) async {
    try {
      _message = "";
      _state = ResState.loading;
      notifyListeners();

      _addStoryResponse = await apiService.addStory(
        description,
        foto,
        await preferenceHelper.getToken,
        fileName,
      );
      _state = ResState.hasData;
      _message = _addStoryResponse!.message.toString();
      notifyListeners();
    } catch (e) {
      _state = ResState.error;
      _message = 'Add Story Gagal , $e';
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> foto) async {
    int imageLength = foto.length;
    if (imageLength < 1000000) return foto;

    final img.Image image = img.decodeImage(foto)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
