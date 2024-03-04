import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import '../domain/business/bloc/favorite_bloc/favorites_list_states.dart';
import '../domain/business/bloc/theme_bloc/theme_bloc.dart';
import '../domain/business/bloc/theme_bloc/theme_states.dart';
import '../domain/models/marvel_hero.dart';
import '../utils/constants/wordings.dart';

class Details extends StatefulWidget {
  const Details({required this.hero, super.key});
  final MarvelHero hero;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FavoritesBloc>();
    return BlocBuilder<ThemeBloc, ThemeStates>(
      builder: (context, state) => Scaffold(
        backgroundColor: state is ThemeLightState
            ? Colors.white
            : const Color.fromARGB(255, 46, 46, 46),
        appBar: AppBar(
          foregroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(color: Colors.amber),
          backgroundColor: const Color.fromARGB(255, 114, 24, 24),
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesStates>(
              builder: (context, state) {
                if (state is FavoriteSuccessState) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: (state.favoriteHeroes.contains(widget.hero))
                          ? IconButton(
                              onPressed: () {
                                bloc.add(
                                    FavoriteRemoveEvent(hero: widget.hero),);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                size: 30,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                bloc.add(FavoriteAddEvent(hero: widget.hero));
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 32,
                              ),
                            ),);
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
                color: const Color.fromARGB(255, 114, 24, 24),
                border: Border.all(
                    color: Colors.black54,
                    width: 0.5,),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.hero.name,
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.hero.image,
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
                        widget.hero.description.length > 3
                            ? widget.hero.description
                            : Wordings.noDescription,
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
