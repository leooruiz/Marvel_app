import 'package:dio/dio.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/utils/constants/api_url.dart';

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
      final List<MarvelHero> heroes = List<MarvelHero>.from(
          response.data['data']['results'].map((e) => MarvelHero.fromMap(e)));
      return heroes;
    }
    throw DioException;
  }
}
