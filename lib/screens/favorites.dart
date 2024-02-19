import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorite_list_states.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/screens/details.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<FavoritesBloc, FavoriteListStates>(
          builder: (context, state) {
            if (state is FavoriteLoadState) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is FavoriteSuccessState) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  return state.favoriteHeroes[index].image != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Ink(
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Details(
                                          hero: state.favoriteHeroes[index]),
                                    )),
                                child: Card(
                                  color: Color.fromARGB(255, 145, 16, 16),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          state.favoriteHeroes[index].image!),
                                      Text(state.favoriteHeroes[index].name!),
                                      Text(state.favoriteHeroes[index].id
                                          .toString()),
                                      // Text(state
                                      //     .favoriteHeroes[index].description
                                      //     .toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child: Center(
                              child: SizedBox(
                          child: Text('TESTING IF ITS NULL'),
                        )));
                },
                itemCount: state.favoriteHeroes.length,
              );
            } else if (state is FavoriteErrorState) {
              return const SliverToBoxAdapter(child: Text('Erro'));
            } else {
              return const SliverToBoxAdapter(
                  child: Center(
                child: Text('Nothing'),
              ));
            }
          },
        )
      ],
    );
  }
}
