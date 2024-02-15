import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_events.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_states.dart';

class FavoritesBloc extends Bloc<FavoriteListEvents, FavoriteListStates> {
  HeroesController heroesController = HeroesController();

  FavoritesBloc() : super(FavoriteLoadState()) {
    on<FavoriteLoadList>(
      (event, emit) {
        emit(FavoriteLoadState());
        try {
          emit(FavoriteSuccessState(
              favoriteHeros: heroesController.favoriteHeroes));
        } catch (e) {
          emit(FavoriteErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<AddFavorite>(
      (event, emit) {
        if (!heroesController.favoriteHeroes.contains(event.hero)) {
          emit(FavoriteSuccessState(
              favoriteHeros: heroesController.addFavoriteHero(event.hero)));
        }
      },
    );
    on<RemoveFavorite>(
      (event, emit) {
        if (heroesController.favoriteHeroes.contains(event.hero)) {
          emit(FavoriteSuccessState(
              favoriteHeros: heroesController.removeFavoriteHero(event.hero)));
        }
      },
    );
  }
}
