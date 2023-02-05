import 'dart:developer';
import 'package:data/sources/network/exceptions/api_exception.dart';
import 'package:domain/entities/api_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class GraphQLService {
  late final GraphQLClient _client;

  GraphQLService() {
    HttpLink link =
        HttpLink("https://rickandmortyapi.com/graphql", defaultHeaders: {});

    _client =
        GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  Future<ApiResponse> performQuery(String query,
      {required Map<String, dynamic> variables}) async {
    try {
      QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
      );

      final result = await _client.query(options);

      if (result.hasException) {
        return Failure(error: APIException(result.exception.toString(), 0, ''));
      } else {
        return Success(data: result.data);
      }
    } on Exception catch (_, e) {
      return Failure(error: APIException("No internet connection", 0, ''));
    }
  }

  Future<QueryResult> performMutation(String query,
      {required Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    log(result.toString());

    return result;
  }
}
