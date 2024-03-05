import 'package:dio/dio.dart';

import '../../domain/models/marvel_hero.dart';
import '../../utils/constants/api_url.dart';

class DataApi {
  final dio = Dio();

  void configureDio() {
    dio.options.baseUrl = ApiUrl.url;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);
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
