import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_events.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  final HeroesController _heroesController = HeroesController();

  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadEvent>((event, emit) => getHeroes(emit));
  }

  void getHeroes(emit) async {
    try {
      emit(HomeLoadingState());
      final heroes = await _heroesController.loadAllHeroes();
      emit(HomeSuccessState(heroes: heroes));
    } on Exception catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
