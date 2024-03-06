import 'package:dio/dio.dart';

import '../../domain/models/marvel_hero.dart';
import '../../utils/constants/api_url.dart';

class DataApi {
  final dio = Dio();

  void configureDio() {
    dio.options = BaseOptions(
      baseUrl: ApiUrl.url,
      queryParameters: {
        'ts': '123',
        'apikey': '044479a19929992d86c53efb86add0a5',
        'hash': 'd7d2e2160357184800ff55f0b845be50',
      },
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6),
    );
  }

  Future<List<MarvelHero>> getHeroesList() async {
    configureDio();
    final Response response = await dio.get(dio.options.baseUrl);
    if (response.statusCode != null &&
        response.statusCode! > 199 &&
        response.statusCode! < 300) {
      final responseList = response.data['data']['results'] as List;

      final List<MarvelHero> heroes = responseList
          .whereType<Map<String, dynamic>>()
          .map(MarvelHero.fromMap)
          .toList();

      return heroes;
    }
    // ignore: only_throw_errors
    throw DioException;
  }
}
