import 'package:marvel_app/domain/models/hero.dart';

abstract class FavoriteListStates {
  FavoriteListStates();
}

class FavoriteLoadState extends FavoriteListStates {
  FavoriteLoadState();
}

class FavoriteSuccessState extends FavoriteListStates {
  FavoriteSuccessState({required this.favoriteHeros});
  List<MarvelHero> favoriteHeros;
}

class FavoriteErrorState extends FavoriteListStates {
  FavoriteErrorState({required this.errorMessage});
  String errorMessage;
}
