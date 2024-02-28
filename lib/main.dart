import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_list_events.dart';
import 'package:marvel_app/domain/business/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_events.dart';
import 'package:marvel_app/screens/home.dart';

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
      ],
      child: MaterialApp(
        routes: {
          Routes.home: (context) => const Home(),
          Routes.favorites: (context) => const Favorites(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == Routes.details) {
            final MarvelHero hero = settings.arguments as MarvelHero;
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.home,
        home: const Home(),
      ),
    );
  }
}
