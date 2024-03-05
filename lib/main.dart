import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import 'domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import 'domain/business/bloc/home_bloc/home_bloc.dart';
import 'domain/business/bloc/home_bloc/home_events.dart';
import 'domain/business/bloc/theme_bloc/theme_bloc.dart';
import 'domain/models/marvel_hero.dart';
import 'screens/details.dart';
import 'screens/favorites.dart';
import 'screens/home.dart';
import 'utils/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesBloc()..add(FavoriteLoadEvent()),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(HomeLoadEvent()),
        ),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: MaterialApp(
        routes: {
          Routes.home: (context) => const Home(),
          Routes.favorites: (context) => const Favorites(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == Routes.details && settings.arguments != null) {
            final MarvelHero hero = settings.arguments! as MarvelHero;
            return MaterialPageRoute(
              builder: (context) {
                return Details(hero: hero);
              },
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: Routes.home,
        home: const Home(),
      ),
    );
  }
}
