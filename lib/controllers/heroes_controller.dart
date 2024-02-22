import 'package:marvel_app/data/api/data_api.dart';
import 'package:marvel_app/data/shared_prefs.dart';
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
    final List<MarvelHero> heroesFromApi = await _dataApi
        .getHeroesList(); //TODO: Usar essa função quando for utilizar lazy load, pois assim a lista será aumentada ao carregar, e observaremos através do BlocBuilder, quando carregar mais (ao scrollar o maximo possivel para baixo) ele irá atualizar a tela automaticamente.
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
