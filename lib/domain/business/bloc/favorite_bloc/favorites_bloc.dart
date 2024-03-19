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
  final HeroesRepository _repo = HeroesRepository();

  Future<void> removeHero(
    FavoriteRemoveEvent event,
    Emitter<FavoritesStates> emit,
  ) async {
    final MarvelHero hero = event.hero;
    final List<MarvelHero> oldFavorites =
        (state as FavoriteSuccessState).favoriteHeroes;
    if (oldFavorites.contains(hero)) {
      await _repo.removeFavoriteHero(hero);
      emit(
        FavoriteSuccessState(
          favoriteHeroes: oldFavorites..remove(hero),
        ),
      );
    }
  }

  Future<void> addHero(
    FavoriteAddEvent event,
    Emitter<FavoritesStates> emit,
  ) async {
    final MarvelHero hero = event.hero;
    final List<MarvelHero> oldFavorites =
        (state as FavoriteSuccessState).favoriteHeroes;
    if (!oldFavorites.contains(hero)) {
      await _repo.addFavoriteHero(hero);
      emit(
        FavoriteSuccessState(
          favoriteHeroes: oldFavorites..add(hero),
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
