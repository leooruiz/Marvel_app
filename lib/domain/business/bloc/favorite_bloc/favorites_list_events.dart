import '../../../models/marvel_hero.dart';

abstract class FavoritesEvents {}

class FavoriteLoadEvent extends FavoritesEvents {}

class FavoriteAddEvent extends FavoritesEvents {
  FavoriteAddEvent({
    required this.hero,
  });
  MarvelHero hero;
}

class FavoriteRemoveEvent extends FavoritesEvents {
  FavoriteRemoveEvent({
    required this.hero,
  });
  MarvelHero hero;
}
