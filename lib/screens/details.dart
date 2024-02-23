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
    final List<String> favoritesIds = [];
    final bloc = context.watch<FavoritesBloc>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Color.fromARGB(255, 114, 24, 24),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesStates>(
            builder: (context, state) {
              if (state is FavoriteSuccessState) {
                // for (var i = 0; i < state.favoriteHeroes.length; i++) {
                //   favoritesIds.add(state.favoriteHeroes[i].id.toString());
                // }
                return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: (state.favoriteHeroes.contains(widget.hero))
                        ? IconButton(
                            onPressed: () {
                              bloc.add(FavoriteRemoveEvent(hero: widget.hero));
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 30,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              favoritesIds.add(widget.hero.id.toString());

                              bloc.add(FavoriteAddEvent(hero: widget.hero));
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 32,
                            ),
                          ));
              }
              return const SizedBox.shrink();
            },
          )

          // ),
        ],
      ),
      // ),
      body: Center( //TODO: COLOCAR BACKGROUND DA MARVEL
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 114, 24, 24),
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.black54, width: 0.5),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      widget.hero.name.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ), //TODO: Google fonts
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Image.network(
                    widget.hero.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      widget.hero.description
                          .toString(), //TODO: IF DESCRIPTION NULL IMPLEMENT 'NO DESCRIPTION'
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ), //TODO:
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
