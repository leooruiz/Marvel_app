import 'package:marvel_app/controllers/api_controller.dart';
import 'package:marvel_app/domain/models/hero.dart';
import 'package:marvel_app/examples/repo.dart';

class HeroesController {
  final List<MarvelHero> favoriteHeroes = [];
  final List<MarvelHero> homeHeroes = [
    marvelHero,
  ];
  ApiController apiController = ApiController();

  Future<List<MarvelHero>> loadHomeHeroes(MarvelHero hero) async {
    final List<MarvelHero> fetchHeroes = await apiController.getHeroes();
    homeHeroes.addAll(fetchHeroes);
    return homeHeroes;
  }

  List<MarvelHero> addFavoriteHero(MarvelHero hero) {
    favoriteHeroes.add(hero);
    return favoriteHeroes;
  }

  List<MarvelHero> removeFavoriteHero(MarvelHero hero) {
    favoriteHeroes.remove(hero);
    return favoriteHeroes;
  }
}
