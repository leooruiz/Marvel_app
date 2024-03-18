import '../../../models/marvel_hero.dart';

abstract class FavoritesStates {
  FavoritesStates();
}

class FavoriteLoadState extends FavoritesStates {
  FavoriteLoadState();
}

class FavoriteSuccessState extends FavoritesStates {
  FavoriteSuccessState({required this.favoriteHeroes});
  List<MarvelHero> favoriteHeroes;
}

class FavoriteErrorState extends FavoritesStates {
  FavoriteErrorState({required this.errorMessage});
  String errorMessage;
}
