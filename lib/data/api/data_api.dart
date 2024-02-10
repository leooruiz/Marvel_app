import 'package:dio/dio.dart';
import 'package:marvel_app/domain/models/hero.dart';
import 'package:marvel_app/utils/constants/api_url.dart';

class DataApi {
  final Dio dio = Dio();

  Future<List<MarvelHero>> getHeroesList() async {
    final response = await dio.get(ApiUrl.url);
    final heroes = List<MarvelHero>.from(
        response.data['data']['results'].map((e) => MarvelHero.fromMap(e)));
    return heroes;
  }
}
