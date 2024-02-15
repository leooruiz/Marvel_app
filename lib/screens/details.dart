import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/controllers/heroes_controller.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_events.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_states.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/domain/models/hero.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.hero});
  final MarvelHero? hero;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  IconData favoriteIcon = Icons.favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<FavoritesBloc, FavoriteListStates>(
              builder: (context, state) {
            context.watch<FavoritesBloc>();
            if (!FavoritesBloc()
                .heroesController
                .favoriteHeroes
                .contains(widget.hero)) {
              print('este NÃO está favoritado.');
              favoriteIcon = Icons.favorite_border;
            }
            return FavoritesBloc()
                    .heroesController
                    .favoriteHeroes
                    .contains(widget.hero)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        context
                            .read<FavoritesBloc>()
                            .add(RemoveFavorite(hero: widget.hero!));
                        favoriteIcon = Icons.favorite_border;
                      });
                      print(FavoritesBloc().heroesController.favoriteHeroes);
                    },
                    icon: Icon(favoriteIcon),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        context
                            .read<FavoritesBloc>()
                            .add(AddFavorite(hero: widget.hero!));
                        favoriteIcon = Icons.favorite;
                      });
                      // print(FavoritesBloc().heroesController.favoriteHeroes);
                    },
                    icon: Icon(favoriteIcon),
                  );
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
