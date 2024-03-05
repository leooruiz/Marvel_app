import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import 'components/hero_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
            }
            if (state is FavoriteSuccessState &&
                state.favoriteHeroes.isNotEmpty) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(
                    hero: state.favoriteHeroes[index],
                  );
                },
                itemCount: state.favoriteHeroes.length,
              );
            }
            if (state is FavoriteSuccessState && state.favoriteHeroes.isEmpty) {
              return SliverList.builder(
                  itemBuilder: (context, index) => const SizedBox.shrink());
            }
            if (state is FavoriteErrorState) {
              return SliverFillRemaining(
                  child: Center(child: Text(state.errorMessage)));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
