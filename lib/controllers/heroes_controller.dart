import 'package:marvel_app/data/api/data_api.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/utils/shared_prefs.dart';

class HeroesController {
  final DataApi dataApi = DataApi();
  final SharedPrefs prefs = SharedPrefs();
  final List<MarvelHero> homeHeroes = [];
  final List<MarvelHero> favoriteHeroes = [];

  Future<List<MarvelHero>> loadAllHeroes() async {
    final heroesFromPrefs = await prefs.getMarvelHeroesFromDatabase();
    print(heroesFromPrefs);
    final List<MarvelHero> heroesFromApi = await dataApi
        .getHeroesList(); //TODO: Usar essa função quando for utilizar lazy load, pois assim a lista será aumentada ao carregar, e observaremos através do BlocBuilder, quando carregar mais (ao scrollar o maximo possivel para baixo) ele irá atualizar a tela automaticamente.
    homeHeroes.addAll(heroesFromApi);
    return homeHeroes;
  }

  Future<List<MarvelHero>> getFavoriteHeroes() async {
    final heroesFromPrefs = await prefs.getMarvelHeroesFromDatabase();
    favoriteHeroes.addAll(heroesFromPrefs);
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> addFavoriteHero(MarvelHero hero) async {
    prefs.addToDatabase(hero);
    favoriteHeroes.add(
      hero,
    ); //TODO: chamar shared preferences aqui, adicionando todas as informações do herói ao shared_prefs.
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> removeFavoriteHero(MarvelHero hero) async {
    prefs.removeFromDatabase(hero);
    favoriteHeroes.remove(hero);
    return favoriteHeroes;
  }
}
