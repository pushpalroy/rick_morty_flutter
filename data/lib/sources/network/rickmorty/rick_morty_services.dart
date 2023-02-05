import 'dart:developer';
import 'package:domain/entities/api_response.dart';
import 'package:injectable/injectable.dart';
import '../../../models/characters/dt_character_list.dart';
import '../graphql/graphql_service.dart';

@injectable
class RickMortyServices {
  final GraphQLService service;

  RickMortyServices(this.service);

  Future<ApiResponse<DTCharactersList>> getCharactersList() async {
    await Future.delayed(const Duration(seconds: 3));
    const query = '''
    query {
        characters(page: 1, filter: { name: "" }) {
          info {
            count
          }
          results {
            name
            image
          }
        }
        location(id: 1) {
          id
        }
        episodesByIds(ids: [1, 2]) {
          id
        }
      }
  ''';

    final response = await service.performQuery(query, variables: {});
    log("$response");

    if (response is Success) {
      return Success(data: DTCharactersList.fromJson(response.data));
    } else {
      return Failure(error: (response as Failure).error);
    }
  }
}
