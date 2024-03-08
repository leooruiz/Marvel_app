import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import '../domain/business/bloc/theme_bloc/theme_bloc.dart';
import '../domain/business/bloc/theme_bloc/theme_states.dart';
import '../domain/models/marvel_hero.dart';
import '../themes/app_colors.dart';
import '../utils/constants/wordings.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.hero, super.key});
  final MarvelHero hero;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoritesBloc>();
    return BlocBuilder<ThemeBloc, ThemeStates>(
      builder: (context, state) => Scaffold(
        backgroundColor:
            state is ThemeLightState ? AppColors.white : AppColors.dark,
        appBar: AppBar(
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesStates>(
              builder: (context, state) {
                if (state is FavoriteSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: (state.favoriteHeroes.contains(hero))
                        ? IconButton(
                            onPressed: () {
                              bloc.add(FavoriteRemoveEvent(hero: hero));
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 30,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              bloc.add(FavoriteAddEvent(hero: hero));
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 32,
                            ),
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // ),
          ],
        ),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 100),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.darkRed,
                border: Border.all(
                  color: AppColors.dark,
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        hero.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        hero.image,
                        fit: BoxFit.cover,
                        width: 280,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: Text(
                        hero.description.length > 3
                            ? hero.description
                            : Wordings.noDescription,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
