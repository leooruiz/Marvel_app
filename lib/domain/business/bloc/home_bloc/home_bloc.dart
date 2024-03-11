import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/heroes_repository.dart';
import '../../../models/marvel_hero.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  ScrollController scrollController = ScrollController();
  int offset = 0;
  bool isLoading = false;
  bool isFirstFetch = true;
  List<MarvelHero> heroes = [];

  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>((event, emit) => getHeroes(emit));
    scrollController.addListener(scrollListener);
  }

  void incrementOffset() {
    offset += 20;
  }

  void scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      isFirstFetch = false;
      incrementOffset();
      print('ativou o scroll máximo');
      getHeroes(emit);
    }
  }

  void getHeroes(dynamic emit) async {
  final HeroesRepository heroesController = HeroesRepository();
  int pages = 0;
  int limit = 15;
  bool isLoading = false;

  Future<void> getHeroes(Emitter<HomeStates> emit) async {
    try {
      emit(HomeLoadingState());
      isLoading = true;
      heroes = await heroesController.loadAllHeroes(offset: offset);
      isLoading = false;
      emit(HomeSuccessState(heroes: heroes));
    } on DioException {
      emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
    }
  }
}
}
