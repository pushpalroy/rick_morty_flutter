import 'dart:developer';
import 'package:data/sources/network/exceptions/api_exception.dart';
import 'package:domain/entities/api_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class GraphQLService {
  GraphQLService() {
    final link = HttpLink('https://rickandmortyapi.com/graphql');
    _graphQLClient = GraphQLClient(link: link, cache: GraphQLCache());
  }

  late final GraphQLClient _graphQLClient;

  Future<ApiResponse<dynamic>> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    try {
      final options = QueryOptions(
        document: gql(query),
        variables: variables,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        var errorCode =
            result.context.entry<HttpLinkResponseContext>()?.statusCode ?? 0;
        return Failure(
          error: APIException(result.exception.toString(), errorCode, ''),
        );
      } else {
        return Success(data: result.data);
      }
    } on Exception catch (_, e) {
      return Failure(error: APIException(e.toString(), 0, ''));
    }
  }

  Future<QueryResult> performMutation(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    final options = MutationOptions(document: gql(query), variables: variables);

    final result = await _graphQLClient.mutate(options);

    log(result.toString());

    return result;
  }
}
