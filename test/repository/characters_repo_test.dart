import 'package:data/sources/network/exceptions/api_exception.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/repositories/characters/characters_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'characters_repo_test.mocks.dart';

class CharactersRepoTest extends Mock implements CharactersRepository {}

@GenerateMocks([CharactersRepoTest])
Future<void> main() async {
  late MockCharactersRepoTest homeRepo;

  setUpAll(() {
    homeRepo = MockCharactersRepoTest();
  });

  group('characters repo test', () {
    test('test getRickAndMortyCharacters', () async {
      final model = CharacterList([
        Character('1', 'TestName', 'TestImage', 'TestStatus', 'TestSpecies')
      ]);

      when(homeRepo.getRickAndMortyCharacters(1, '')).thenAnswer((_) async {
        return Future(() => Success(data: model));
      });

      final res = await homeRepo.getRickAndMortyCharacters(1, '');
      expect(res, isA<ApiResponse<CharacterList>>());
    });

    test('test getRickAndMortyCharacters throws Exception', () async {
      when(homeRepo.getRickAndMortyCharacters(1, '')).thenAnswer((_) async {
        return Future(
          () => Failure(error: Exception('TestMessage')),
        );
      });

      final res = await homeRepo.getRickAndMortyCharacters(1, '');
      expect(res, isA<ApiResponse<CharacterList>>());
    });
  });
}
