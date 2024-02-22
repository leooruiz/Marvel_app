import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesStates> {
  final HeroesController _repo = HeroesController();

  void getHeroes(emit) async {
    final List<MarvelHero> heroes = await _repo.getFavoriteHeroes();
    emit(FavoriteLoadState());
    try {
      emit(FavoriteSuccessState(favoriteHeroes: heroes));
    } catch (e) {
      emit(FavoriteErrorState(errorMessage: e.toString()));
    }
  }

  FavoritesBloc() : super(FavoriteLoadState()) {
    on<FavoriteLoadEvent>(
      (event, emit) => getHeroes(emit),
    );
    void removeHero(emit, event) async {
      if (_repo.favoriteHeroes.contains(event.hero)) {
        emit(FavoriteSuccessState(
            favoriteHeroes: await _repo.removeFavoriteHero(event.hero)));
      }
    }

    void addHero(emit, event) async {
      if (!_repo.favoriteHeroes.contains(event.hero)) {
        emit(FavoriteSuccessState(
            favoriteHeroes: await _repo.addFavoriteHero(event.hero)));
      }
    }

    on<FavoriteAddEvent>(
      (event, emit) => addHero(emit, event),
    );

    on<FavoriteRemoveEvent>(
      (event, emit) => removeHero(emit, event),
    );
  }
}
