import 'package:floor/floor.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

@dao
abstract class MarvelHeroDao {
  @Query('SELECT * FROM MARVELHERO')
  Future<List<MarvelHero>> getAllHeroes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addHero(MarvelHero hero);

  @delete
  Future<void> removeHero(MarvelHero hero);
}
