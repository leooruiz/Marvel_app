import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/api_controller.dart';
import 'package:marvel_app/data/bloc/home_bloc/home_list_events.dart';
import 'package:marvel_app/data/bloc/home_bloc/home_list_states.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListStates> {
  final ApiController _apiController = ApiController();

  HomeListBloc() : super(HomeLoadingState()) {
    on<HomeLoadHeroes>((event, emit) => getHeroes(emit));
  }

  void getHeroes(emit) async {
    try {
      emit(HomeLoadingState());
      final heroes = await _apiController.getHeroes();
      emit(HomeSuccessState(heroes: heroes));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
