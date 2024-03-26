import '../../../models/marvel_hero.dart';

abstract class HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeLoadingNextState extends HomeStates {
  HomeLoadingNextState({required this.heroes});
  List<MarvelHero> heroes;
}

class HomeSuccessState extends HomeStates {
  HomeSuccessState({required this.heroes});
  List<MarvelHero> heroes;
}

class HomeErrorState extends HomeStates {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
