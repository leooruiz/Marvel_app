import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import 'components/hero_card.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<FavoritesBloc, FavoritesStates>(
          builder: (context, state) {
            if (state is FavoriteLoadState) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 179, 0, 0),
                  ),
                ),
              );
            } else if (state is FavoriteSuccessState) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(heroes: state.favoriteHeroes, index: index);
                },
                itemCount: state.favoriteHeroes.length,
              );
            } else if (state is FavoriteErrorState) {
              return SliverToBoxAdapter(child: Text(state.errorMessage));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
