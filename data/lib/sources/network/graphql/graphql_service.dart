import 'dart:developer';
import 'package:data/sources/network/exceptions/api_exception.dart';
import 'package:data/sources/network/graphql/query/__generated__/character_card.req.gql.dart';
import 'package:domain/entities/api_response.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class GraphQLService {
  late final Future<Client> _client;

  GraphQLService() {
    _client = initClient();
  }

  Future<Client> initClient() async {
    await Hive.initFlutter();
    final box = await Hive.openBox<Map<String, dynamic>>("graphql");
    await box.clear();
    final store = HiveStore(box);
    final cache = Cache(store: store);
    final link = HttpLink("https://rickandmortyapi.com/graphql");
    final client = Client(
      link: link,
      cache: cache,
    );
    return client;
  }

  Future<ApiResponse> performQuery(String query,
      {required Map<String, dynamic> variables}) async {
    try {
      final client = await _client;
      final charactersReq = GCharacterCardReq();
      var result = client.request(charactersReq as OperationRequest).first;
      result
          .whenComplete(() => Success(data: result));
      result
          .onError((error, stackTrace) => Failure(''));
    } on Exception catch (_, e) {
      return Failure(error: APIException("No internet connection", 0, ''));
    }
  }
}
