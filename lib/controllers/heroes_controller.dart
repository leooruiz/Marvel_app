import '../data/api_service/data_api.dart';
import '../data/dao_service/shared_prefs.dart';
import '../domain/models/marvel_hero.dart';

class HeroesRepository {
  final DataApi _dataApi = DataApi();
  final SharedPrefs _prefs = SharedPrefs();

  Future<List<MarvelHero>> loadAllHeroes() async {
    final List<MarvelHero> heroesFromApi = await _dataApi.getHeroesList();
    return heroesFromApi;
  }

  Future<List<MarvelHero>> getFavoriteHeroes() async {
    final List<MarvelHero> heroesFromPrefs =
        await _prefs.getMarvelHeroesFromDatabase();
    return heroesFromPrefs;
  }

  Future<List<MarvelHero>> addFavoriteHero(MarvelHero hero) async {
    await _prefs.addToDatabase(hero);
    final List<MarvelHero> heroesFromPrefs =
        await _prefs.getMarvelHeroesFromDatabase();
    return heroesFromPrefs;
  }

  Future<List<MarvelHero>> removeFavoriteHero(MarvelHero hero) async {
    await _prefs.removeFromDatabase(hero);
    final List<MarvelHero> heroesFromPrefs =
        await _prefs.getMarvelHeroesFromDatabase();
    return heroesFromPrefs;
  }
}
