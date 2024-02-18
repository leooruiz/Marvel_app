import 'package:marvel_app/controllers/api_controller.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeroesController {
  final ApiController apiController = ApiController();
  final SharedPrefs prefs = SharedPrefs();
  final List<MarvelHero> homeHeroes = [];
  final List<MarvelHero> favoriteHeroes = [];

  Future<List<MarvelHero>> loadHomeHeroes(MarvelHero hero) async {
    final List<MarvelHero> fetchHeroes = await apiController
        .getHeroes(); //TODO: Usar essa função quando for utilizar lazy load, pois assim a lista será aumentada ao carregar, e observaremos através do BlocBuilder, quando carregar mais (ao scrollar o maximo possivel para baixo) ele irá atualizar a tela automaticamente.
    homeHeroes.addAll(fetchHeroes);
    return homeHeroes;
  }

  Future<List<MarvelHero>> getFavoriteHeroes() async {
    final heroesFromPrefs = await prefs.getMarvelHeroesFromDatabase();
    favoriteHeroes.addAll(heroesFromPrefs);
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> addFavoriteHero(MarvelHero hero) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(hero.id.toString(), hero.id.toString());
    prefs.addToDatabase(hero);
    favoriteHeroes.add(
      hero,
    ); //TODO: chamar shared preferences aqui, adicionando todas as informações do herói ao shared_prefs.
    return favoriteHeroes;
  }

  Future<List<MarvelHero>> removeFavoriteHero(MarvelHero hero) async {
    // final SharedPreferences prefs = await SharedPreferences
    //     .getInstance(); //TODO: melhorar esta função, talvez juntar com a de cima.
    // prefs.remove(hero.id.toString());
    favoriteHeroes.remove(hero);
    return favoriteHeroes;
  }
}
