import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/heroes_repository.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>((event, emit) => getHeroes(emit));
  }

  final HeroesRepository _heroesController = HeroesRepository();
  int pages = 0;
  int limit = 15;
  bool isLoading = false;

  Future<void> getHeroes(Emitter emit) async {
    try {
      emit(HomeLoadingState());
      final heroes = await _heroesController.loadAllHeroes();
      emit(HomeSuccessState(heroes: heroes));
    } on DioException {
      emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
    } on Exception {
      emit(HomeErrorState(errorMessage: 'Algo deu Errado'));
    }
  }
}
