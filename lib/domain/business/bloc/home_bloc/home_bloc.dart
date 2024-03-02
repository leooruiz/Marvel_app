import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_events.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  final HeroesController _heroesController = HeroesController();
  int offset = 0;
  bool isLoading = false;
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>((event, emit) => getHeroes(emit));
  }
  void getHeroes(emit) async {
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
