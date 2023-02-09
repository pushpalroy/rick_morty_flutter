import 'dart:developer';
import 'package:domain/entities/api_response.dart';
import 'package:injectable/injectable.dart';
import '../../../models/characters/dt_character_info.dart';
import '../../../models/characters/dt_character_list.dart';
import '../graphql/graphql_service.dart';

@injectable
class RickMortyServices {
  final GraphQLService service;

  RickMortyServices(this.service);

  Future<ApiResponse<DTCharactersList>> getCharactersList(int page, String nameFilter) async {
    final query = '''
      query {
        characters(page: $page, filter: { name: "$nameFilter" }) {
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

  Future<ApiResponse<DTCharacterInfo>> getCharacterInfo(int id) async {
    final query = '''{
      character(id: $id) {
        id
        name
        image
        status
        species
        gender
        origin {
          id
          name
        }
        location {
          id
          name
        }
      }
    }''';

    final response = await service.performQuery(query, variables: {});
    log("$response");

    if (response is Success) {
      DTCharacterInfo? a;
      try {
        a = DTCharacterInfo.fromJson(response.data['character']);
      } catch (e) {
        log("error", error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: a);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }
}
