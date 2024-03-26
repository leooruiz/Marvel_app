import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/heroes_repository.dart';
import '../../../models/marvel_hero.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>(_getHeroes);
    on<HomeLoadNextEvent>(_getMoreHeroes);
  }
  final HeroesRepository heroesRepository = HeroesRepository();
  late int offset = 0;
  bool isLoading = false;

  void incrementOffset() {
    offset += 20;
  }

  Future<void> _getMoreHeroes(
    HomeLoadNextEvent event,
    Emitter<HomeStates> emit,
  ) async {
    if (state is HomeSuccessState) {
      try {
        isLoading = true;
        final List<MarvelHero> currentHeroes =
            (state as HomeSuccessState).heroes;
        emit(HomeLoadingNextState(heroes: currentHeroes));
        final List<MarvelHero> heroesFromApi =
            await heroesRepository.loadAllHeroes(offset: offset);
        final List<MarvelHero> updatedHeroes = currentHeroes
          ..addAll(heroesFromApi);
        incrementOffset();
        isLoading = false;
        emit(
          HomeSuccessState(heroes: updatedHeroes),
        );
      } on DioException {
        emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
      } on Exception {
        emit(HomeErrorState(errorMessage: 'Algo deu errado'));
      }
    }
  }

  Future<void> _getHeroes(
    HomeLoadEvent event,
    Emitter<HomeStates> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      isLoading = true;
      final heroesFromApi =
          await heroesRepository.loadAllHeroes(offset: offset);
      isLoading = false;
      incrementOffset();
      emit(
        HomeSuccessState(heroes: heroesFromApi),
      );
    } on DioException {
      emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
    } on Exception {
      emit(HomeErrorState(errorMessage: 'Algo deu errado'));
    }
  }
}
