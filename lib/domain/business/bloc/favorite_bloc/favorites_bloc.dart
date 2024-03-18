import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/heroes_repository.dart';
import '../../../models/marvel_hero.dart';
import 'favorites_list_events.dart';
import 'favorites_list_states.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesStates> {
  FavoritesBloc() : super(FavoriteLoadState()) {
    on<FavoriteLoadEvent>(
      (event, emit) => getHeroes(emit),
    );
    on<FavoriteAddEvent>(
      addHero,
    );
    on<FavoriteRemoveEvent>(
      removeHero,
    );
  }
  Future<void> removeHero(
    FavoriteRemoveEvent event,
    Emitter<FavoritesStates> emit,
  ) async {
    if ((await _repo.getFavoriteHeroes()).contains(event.hero)) {
      emit(
        FavoriteSuccessState(
          favoriteHeroes: await _repo.removeFavoriteHero(event.hero),
        ),
      );
    }
  }

  final HeroesRepository _repo = HeroesRepository();
  Future<void> addHero(
    FavoriteAddEvent event,
    Emitter<FavoritesStates> emit,
  ) async {
    if (!(await _repo.getFavoriteHeroes()).contains(event.hero)) {
      emit(
        FavoriteSuccessState(
          favoriteHeroes: await _repo.addFavoriteHero(event.hero),
        ),
      );
    }
  }

  Future<void> getHeroes(Emitter<FavoritesStates> emit) async {
    final List<MarvelHero> heroes = await _repo.getFavoriteHeroes();
    emit(FavoriteLoadState());
    try {
      emit(FavoriteSuccessState(favoriteHeroes: heroes));
    } on Exception catch (e) {
      emit(FavoriteErrorState(errorMessage: e.toString()));
    }
  }
}
