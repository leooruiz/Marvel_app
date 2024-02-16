import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_events.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_states.dart';
import 'package:marvel_app/utils/shared_prefs.dart';

class FavoritesBloc extends Bloc<FavoriteListEvents, FavoriteListStates> {
  final HeroesController _heroesController = HeroesController();
  final SharedPrefs prefs = SharedPrefs();

  FavoritesBloc() : super(FavoriteLoadState()) {
    on<FavoriteLoadList>(
      (event, emit) {
        emit(FavoriteLoadState());
        try {
          emit(FavoriteSuccessState(
              favoriteHeroes: _heroesController.favoriteHeroes));
        } catch (e) {
          emit(FavoriteErrorState(errorMessage: e.toString()));
        }
      },
    );
    void removeHero(emit, event) async {
      if (_heroesController.favoriteHeroes.contains(event.hero)) {
        emit(FavoriteSuccessState(
            favoriteHeroes:
                await _heroesController.removeFavoriteHero(event.hero)));
      }
    }

    void addHero(emit, event) async {
      if (!_heroesController.favoriteHeroes.contains(event.hero)) {
        emit(FavoriteSuccessState(
            favoriteHeroes:
                await _heroesController.addFavoriteHero(event.hero)));
      }
    }

    on<AddFavorite>(
      (event, emit) => addHero(emit, event),
    );

    on<RemoveFavorite>(
      (event, emit) => removeHero(emit, event),
    );
  }
}
