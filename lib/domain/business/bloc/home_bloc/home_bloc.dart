import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_events.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_states.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  final HeroesController _heroesController = HeroesController();
  ScrollController scrollController = ScrollController();
  int offset = 0;
  bool isLoading = false;
  bool isFirstFetch = true;
  List<MarvelHero> oldList = [];
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
    try {
      emit(HomeLoadingState());
      isLoading = true;
      final heroes = await _heroesController.loadAllHeroes(offset: offset);
      oldList.addAll(heroes);
      isLoading = false;
      emit(HomeSuccessState(heroes: heroes));
    } on DioException {
      emit(HomeErrorState(errorMessage: 'Erro de conexão com o servidor'));
    }
  }
}
