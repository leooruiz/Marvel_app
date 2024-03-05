import 'package:marvel_app/data/api_service/data_api.dart';
import 'package:marvel_app/data/dao_service/shared_prefs.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class HeroesController {
  final DataApi _dataApi = DataApi();
  final SharedPrefs _prefs = SharedPrefs();
  final List<MarvelHero> homeHeroes = [];
  final List<MarvelHero> favoriteHeroes = [];

  Future<List<MarvelHero>> loadAllHeroes() async {
    // final List<MarvelHero> heroesFromPrefs =
    //     await _prefs.getMarvelHeroesFromDatabase();
    // print(heroesFromPrefs);
    final List<MarvelHero> heroesFromApi = await _dataApi.getHeroesList();
    homeHeroes.addAll(heroesFromApi);
    return homeHeroes;
  }

  Future<List<MarvelHero>> getFavoriteHeroes() async {
    final List<MarvelHero> heroesFromPrefs =
        await _prefs.getMarvelHeroesFromDatabase();
    favoriteHeroes.addAll(heroesFromPrefs);
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> addFavoriteHero(MarvelHero hero) async {
    _prefs.addToDatabase(hero);
    favoriteHeroes.add(
      hero,
    );
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> removeFavoriteHero(MarvelHero hero) async {
    _prefs.removeFromDatabase(hero);
    favoriteHeroes.remove(hero);
    return favoriteHeroes;
  }
}
