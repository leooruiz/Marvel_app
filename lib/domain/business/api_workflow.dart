import 'package:marvel_app/domain/models/marvel_hero.dart';

abstract class ApiWorkFlow {
  Future<List<MarvelHero>> getHeroes();
}
