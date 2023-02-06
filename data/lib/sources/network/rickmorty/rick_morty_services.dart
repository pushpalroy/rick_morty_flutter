import 'dart:developer';
import 'package:domain/entities/api_response.dart';
import 'package:injectable/injectable.dart';
import '../../../models/characters/dt_character_list.dart';
import '../graphql/graphql_service.dart';

@injectable
class RickMortyServices {
  final GraphQLService service;

  RickMortyServices(this.service);

  Future<ApiResponse<DTCharactersList>> getCharactersList(int page) async {
    final query = '''
    query {
        characters(page: $page, filter: { name: "" }) {
          info {
            count
          }
          results {
            id
            name
            status
            image
            species
          }
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
