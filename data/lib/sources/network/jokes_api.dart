import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:data/mapper/jokes/jokes_mappers.dart';
import 'package:data/models/jokes/dt_joke_list.dart';
import 'package:data/sources/network/exceptions/api_exception.dart';
import 'package:data/sources/network/url.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/jokes/dm_joke_list.dart';
import 'package:logging/logging.dart';

const String genericApiFailMsg = "Unexpected API response!";

@injectable
class JokesApi {
  final _logger = Logger('jokesApi');
  final dio = Dio();
  final JokesListMapper _mapper;

  JokesApi(this._mapper);

  Future<ApiResponse<JokesListWithType>> getFiveRandomJokes() async {
    try {
      final networkResponse = await dio.get(URL.fiveRandomJokesUrl);
      if (networkResponse.data != null) {
        final parsedDataResponse = DTJokeList.fromJson(networkResponse.data);
        final parsedDomainResponse = _mapper.mapToDomain(parsedDataResponse);
        return Success(data: parsedDomainResponse);
      } else {
        return Failure(
            error: APIException(
                networkResponse.statusMessage ?? genericApiFailMsg,
                networkResponse.statusCode ?? 0,
                networkResponse.statusMessage ?? genericApiFailMsg));
      }
    } on Exception catch (e, _) {
      _logger.log(Level.WARNING, "API Error: ${e.toString()}");
      return Failure(error: e);
    }
  }
}
