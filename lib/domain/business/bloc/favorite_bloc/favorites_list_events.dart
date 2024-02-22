import 'package:marvel_app/domain/models/marvel_hero.dart';

abstract class FavoritesEvents {}

class FavoriteLoadEvent extends FavoritesEvents {}

class FavoriteAddEvent extends FavoritesEvents {
  MarvelHero hero;
  FavoriteAddEvent({
    required this.hero,
  });
}

class FavoriteRemoveEvent extends FavoritesEvents {
  MarvelHero hero;
  FavoriteRemoveEvent({
    required this.hero,
  });
}
