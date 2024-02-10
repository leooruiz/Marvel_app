import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_events.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorite_list_states.dart';
import 'package:marvel_app/data/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/screens/details.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc()..add(FavoriteLoadList()),
      child: Builder(builder: (context) {
        context.read<FavoritesBloc>();
        return CustomScrollView(
          slivers: [
            BlocBuilder<FavoritesBloc, FavoriteListStates>(
              builder: (context, state) {
                print(state);
                if (state is FavoriteLoadState) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is FavoriteSuccessState) {
                  print(state.favoriteHeros);
                  return SliverList.builder(
                    itemBuilder: (context, index) {
                      return state.favoriteHeros[index].image != null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Ink(
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                                  hero: state
                                                      .favoriteHeros[index],
                                                ))),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Text(state.favoriteHeros[index].name
                                              .toString()),
                                          Text(state.favoriteHeros[index].id
                                              .toString()),
                                          Text(state
                                              .favoriteHeros[index].description
                                              .toString()),
                                          Image.network(state
                                              .favoriteHeros[index].image!),
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
                    itemCount: state.favoriteHeros.length,
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
      }),
    );
  }
}
