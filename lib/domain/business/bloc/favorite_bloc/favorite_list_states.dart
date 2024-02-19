import 'package:marvel_app/domain/models/marvel_hero.dart';

abstract class FavoriteListStates {
  FavoriteListStates();
}

class FavoriteLoadState extends FavoriteListStates {
  FavoriteLoadState();
}

class FavoriteSuccessState extends FavoriteListStates {
  FavoriteSuccessState({required this.favoriteHeroes});
  List<MarvelHero> favoriteHeroes;
}

class FavoriteErrorState extends FavoriteListStates {
  FavoriteErrorState({required this.errorMessage});
  String errorMessage;
}
