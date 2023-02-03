import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:data/mapper/jokes/jokes_mappers.dart';
import 'package:data/sources/local/database.dart';
import 'package:data/sources/network/jokes_api.dart';
import 'package:data/utils/platform_utils.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/jokes/dm_joke_list.dart';
import 'package:domain/repositories/jokes/jokes_repository.dart';

@Injectable(as: JokesRepository)
class DataJokesRepository implements JokesRepository {
  final JokesListMapper mapper;

  final JokesApi _jokesApi;
  final PraxisDatabase _praxisDatabase;
  final JokeMapper _jokeMapper;

  DataJokesRepository(
      this.mapper, this._jokesApi, this._praxisDatabase, this._jokeMapper);

  @override
  Future<ApiResponse<JokesListWithType>> getFiveRandomJokes() async {
    // Checking platform since sqflite doesn't support WEB
    if (isMobile()) {
      try {
        final networkResponse = await _jokesApi.getFiveRandomJokes();
        if (networkResponse is Success) {
          await _praxisDatabase.deleteAllJokes();
          final networkJokes = (networkResponse as Success).data as JokesListWithType;
          final jokes = mapper.mapToData(networkJokes);
          for (var joke in jokes.jokeList) {
            _praxisDatabase.insertJoke(joke);
          }
        }
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
      final dbJokes = await _praxisDatabase.getAllJokes();
      final domainJokes =
          dbJokes.map((dbJoke) => _jokeMapper.mapToDomain(dbJoke)).toList();
      return Success(data: JokesListWithType( domainJokes));
    } else {
      return _jokesApi.getFiveRandomJokes();
    }
  }
}
