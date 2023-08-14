import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:character_viewer/model/character.dart';
import 'package:character_viewer/provider/character_provider.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('CharacterProvider', () {
    late CharacterProvider characterProvider;
    late MockSharedPreferences mockSharedPreferences;
    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      characterProvider = CharacterProvider();
    });

    test('Initial characters list is empty', () {
      expect(characterProvider.characters.isEmpty, true);
    });

    test('getCharacters returns a list of characters on success', () async {
      const mockResponse = '''{
              "RelatedTopics": [
                {
                  "Text": "Character 1",
                  "Result": "Description 1",
                  "FirstURL": "URL 1"
                },
                {
                  "Text": "Character 2",
                  "Result": "Description 2",
                  "FirstURL": "URL 2"
                }
                ]}''';
      when(mockSharedPreferences.getString('url')).thenReturn(
          'http://api.duckduckgo.com/?q=the+wire+characters&format=json');
      characterProvider.httpClient = MockHttpClient(mockResponse);
      characterProvider.prefs = mockSharedPreferences;
      final characters = await characterProvider.getCharacters();

      expect(characters.isNotEmpty, true);
      expect(characters.length, 2);
      expect(characters, isA<List<Character>>());
      expect(characters[0].title, 'Character 1');
      expect(characters[0].description, 'Description 1');
      expect(characters[0].firstURL, 'URL 1');
      expect(characters[0].isActive, true);
      expect(characters[1].title, 'Character 2');
      expect(characters[1].description, 'Description 2');
      expect(characters[1].firstURL, 'URL 2');
      expect(characters[1].isActive, false);
    });

    test('getCharacters throws an exception on API failure', () async {
      characterProvider.httpClient = MockHttpClientError();
      expect(
        () async => await characterProvider.getCharacters(),
        throwsA(isException),
      );
    });

    test('Throw exception when URL is not set', () async {
      when(mockSharedPreferences.getString('url')).thenReturn(null);
      expect(
        () async => await characterProvider.getCharacters(),
        throwsA(isException),
      );
    });
  });
}

class MockHttpClient extends Mock implements http.Client {
  final String response;
  MockHttpClient(this.response);
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return Future.value(http.Response(response, 200));
  }
}

class MockHttpClientError extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return Future.value(http.Response('Error', 500));
  }
}
