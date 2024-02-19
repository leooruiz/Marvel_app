import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_events.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_states.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListStates> {
  final HeroesController _heroesController = HeroesController();

  HomeListBloc() : super(HomeLoadingState()) {
    on<HomeLoadHeroes>((event, emit) => getHeroes(emit));
  }

  void getHeroes(emit) async {
    try {
      emit(HomeLoadingState());
      final heroes = await _heroesController.loadAllHeroes();
      emit(HomeSuccessState(heroes: heroes));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
