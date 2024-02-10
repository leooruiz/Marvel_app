import 'package:marvel_app/domain/models/hero.dart';

abstract class HomeListStates {}

class HomeLoadingState extends HomeListStates {}

class HomeSuccessState extends HomeListStates {
  HomeSuccessState({required this.heroes});
  final List<MarvelHero> heroes;
}

class HomeErrorState extends HomeListStates {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
