import 'package:dio/dio.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/utils/constants/api_url.dart';

class DataApi {
  final Dio _dio = Dio();

  Future<List<MarvelHero>> getHeroesList() async {
    final Response response = await _dio.get(ApiUrl.url);
    final List<MarvelHero> heroes = List<MarvelHero>.from(
        response.data['data']['results'].map((e) => MarvelHero.fromMap(e)));
    return heroes;
  }
}
