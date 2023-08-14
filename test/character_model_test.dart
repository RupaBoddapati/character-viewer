import 'package:flutter_test/flutter_test.dart';
import 'package:character_viewer/model/character.dart';

void main() {
  group('Character', () {
    test('fromJson creates a Character instance from valid JSON', () {
      final json = {
        'Text': 'Character Title',
        'Icon': {'URL': 'image_url'},
        'Result': 'Description of the character.',
        'FirstURL': 'first_url'
      };

      final character = Character.fromJson(json, 0);

      expect(character.title, 'Character Title');
      expect(character.image, 'image_url');
      expect(character.description, 'Description of the character.');
      expect(character.firstURL, 'first_url');
    });

    test('fromJson handles null image field in JSON', () {
      final json = {
        'Text': 'Character Title',
        'Icon': null,
        'Result': 'Description of the character.',
        'FirstURL': 'first_url'
      };

      final character = Character.fromJson(json, 0);

      expect(character.title, 'Character Title');
      expect(character.image, isNull);
      expect(character.description, 'Description of the character.');
      expect(character.firstURL, 'first_url');
    });

    test('fromJson throws an exception if required fields are missing', () {
      final json = {
        'Icon': {'URL': 'image_url'},
        'Result': 'Description of the character.',
        'FirstURL': 'first_url'
      };

      expect(() => Character.fromJson(json, 0), throwsA(isA<TypeError>()));
    });
  });
}
