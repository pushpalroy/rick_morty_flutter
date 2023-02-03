import 'dart:async';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/jokes/dm_joke_list.dart';

abstract class JokesRepository {
  Future<ApiResponse<JokesListWithType>> getFiveRandomJokes();
}