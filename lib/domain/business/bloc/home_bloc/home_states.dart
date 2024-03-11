import '../../../models/marvel_hero.dart';

abstract class HomeStates {}

class HomeLoadingState extends HomeStates {
}

class HomeSuccessState extends HomeStates {
  HomeSuccessState({required this.heroes});
  final List<MarvelHero> heroes;
}

class HomeErrorState extends HomeStates {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
