import 'package:marvel_app/domain/models/hero.dart';

abstract class ApiWorkFlow {
  Future<List<MarvelHero>> getHeroes();
}
