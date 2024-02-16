import 'package:marvel_app/data/api/data_api.dart';
import 'package:marvel_app/domain/business/api_workflow.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class ApiController implements ApiWorkFlow {
  DataApi dataApi = DataApi();

  @override
  Future<List<MarvelHero>> getHeroes() async {
    final List<MarvelHero> heroesList = await dataApi.getHeroesList();
    return heroesList;
  }
}
