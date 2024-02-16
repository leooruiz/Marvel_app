import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_events.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_states.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.hero});
  final MarvelHero? hero;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<FavoritesBloc, FavoriteListStates>(
              builder: (context, state) {
            if (state is FavoriteSuccessState) {
              return state.favoriteHeroes.contains(widget.hero)
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(RemoveFavorite(hero: widget.hero!));
                      },
                      icon: const Icon(Icons.favorite),
                    )
                  : IconButton(
                      onPressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(AddFavorite(hero: widget.hero!));
                      },
                      icon: const Icon(Icons.favorite_border),
                    );
            }

            return const SizedBox.shrink();
          }),

          // ),
        ],
      ),
      // ),
      body: Column(
        children: [
          Text(widget.hero!.name.toString()),
          Image.network(widget.hero!.image.toString()),
          Text(widget.hero!.description.toString()),
        ],
      ),
    );
  }
}
