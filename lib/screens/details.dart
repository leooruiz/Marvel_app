import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.hero});
  final MarvelHero hero;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FavoritesBloc>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesStates>(
            builder: (context, state) {
              if (state is FavoriteSuccessState) {
                final List<MarvelHero> favoriteHeroes = state.favoriteHeroes;
                final List<int> favoritesIds = [];
                for (var i = 0; i < favoriteHeroes.length; i++) {
                  favoritesIds.add(favoriteHeroes[i].id);
                }
                return (favoritesIds.contains(widget.hero.id))
                    ? IconButton(
                        onPressed: () {
                          bloc.add(FavoriteRemoveEvent(hero: widget.hero));
                        },
                        icon: const Icon(Icons.favorite),
                      )
                    : IconButton(
                        onPressed: () {
                          bloc.add(FavoriteAddEvent(hero: widget.hero));
                        },
                        icon: const Icon(Icons.favorite_border),
                      );
              }
              return const SizedBox.shrink();
            },
          )

          // ),
        ],
      ),
      // ),
      body: Column(
        children: [
          Text(widget.hero.name.toString()),
          Image.network(widget.hero.image.toString()),
          Text(widget.hero.description.toString()),
        ],
      ),
    );
  }
}
