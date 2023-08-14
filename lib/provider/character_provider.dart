import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/character.dart';

class CharacterProvider with ChangeNotifier {
  List<Character> _characters = [];
  http.Client? _httpClient;
  SharedPreferences? _prefs;

  set prefs(SharedPreferences? prefs) {
    _prefs = prefs;
  }

  set httpClient(http.Client? client) {
    _httpClient = client;
  }

  List<Character> get characters => List.from(_characters);

  void setPrefs(SharedPreferences? prefs) {
    _prefs = prefs;
  }

  Character findById(UniqueKey id) {
    return _characters.firstWhere((element) => element.id == id);
  }

  Character? findByActive() {
    final activeCharacters =
        _characters.where((element) => element.isActive).toList();
    return activeCharacters.isNotEmpty ? activeCharacters.first : null;
  }

  void setActive(UniqueKey id) {
    int index = _characters.indexWhere((element) => element.isActive);
    if (index != -1) {
      _characters[index].isActive = false;
      notifyListeners();
    }

    index = _characters.indexWhere((element) => element.id == id);
    if (index != -1) {
      _characters[index].isActive = true;
      notifyListeners();
    }
  }

  Future<List<Character>> getCharacters() async {
    final String? url = _prefs?.getString('url');
    if (url == null) {
      throw Exception('URL is not set in SharedPreferences');
    }
    try {
      final response = await _httpClient?.get(Uri.parse(url));
      if (response?.statusCode == 200) {
        final charactersJson = jsonDecode(response!.body);

        _characters = (charactersJson['RelatedTopics'] as List)
            .map((characterJson) => Character.fromJson(characterJson, 0))
            .toList();
        _characters[0].isActive = true;
        notifyListeners();
        return _characters;
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
