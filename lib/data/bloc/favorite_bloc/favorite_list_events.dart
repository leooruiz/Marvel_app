import 'package:marvel_app/domain/models/marvel_hero.dart';

abstract class FavoriteListEvents {}

class FavoriteLoadList extends FavoriteListEvents {}

class AddFavorite extends FavoriteListEvents {
  MarvelHero hero;
  AddFavorite({
    required this.hero,
  });
}

class RemoveFavorite extends FavoriteListEvents {
  MarvelHero hero;
  RemoveFavorite({
    required this.hero,
  });
}
