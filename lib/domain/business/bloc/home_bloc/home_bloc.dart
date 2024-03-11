import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/heroes_repository.dart';
import '../../../models/marvel_hero.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>(getHeroes);
  }
  late int offset = 0;
  List<MarvelHero> heroes = [];
  bool isFirstFetch = true;
  bool isLoading = false;
  
  void incrementOffset() {
    offset += 15;
  }

  Future<void> getHeroes(HomeLoadEvent event ,Emitter<HomeStates> emit) async {
    final HeroesRepository heroesRepository = HeroesRepository();
    try {
      emit(HomeLoadingState());
      isLoading = true;
      final heroesFromApi =
          await heroesRepository.loadAllHeroes(offset: offset);
      heroes.addAll(heroesFromApi);
      isLoading = false;
      isFirstFetch = false;
      incrementOffset();
      emit(HomeSuccessState(heroes: heroes));
    } on DioException {
      emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
    }
  }
}
