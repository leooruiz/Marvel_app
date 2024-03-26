import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/marvel_hero.dart';

class FavoritesSharedPrefs {
  Future<void> removeFromDatabase(MarvelHero hero) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(hero.name, hero.toJson());
    final String? currentHero = prefs.getString(hero.name);
    final List<String> listaPrefs = prefs.getStringList('favoriteHeroes') ?? [];
    if (listaPrefs.contains(currentHero)) {
      listaPrefs.remove(currentHero);
      await prefs.setStringList('favoriteHeroes', listaPrefs);
    }
  }

  Future<void> addToDatabase(MarvelHero hero) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(hero.name, hero.toJson());
    final String? currentHero = prefs.getString(hero.name);
    final List<String> listaPrefs = prefs.getStringList('favoriteHeroes') ?? [];
    if (!listaPrefs.contains(currentHero)) {
      listaPrefs.add(currentHero!);
      await prefs.setStringList('favoriteHeroes', listaPrefs);
    }
  }

  Future<List<String>> getDatabase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoritesDatabase =
        prefs.getStringList('favoriteHeroes') ?? [];
    return favoritesDatabase;
  }

  Future<List<MarvelHero>> getMarvelHeroesFromDatabase() async {
    final List<String> database = await getDatabase();
    final List<MarvelHero> favoriteMarvelHeroes = [];
    for (var i = 0; i < database.length; i++) {
      favoriteMarvelHeroes.add(_fromMapToHero(_fromJsonToMap(database[i])));
    }
    return favoriteMarvelHeroes;
  }

  Map<String, dynamic> _fromJsonToMap(String source) => jsonDecode(source);

  MarvelHero _fromMapToHero(Map<String, dynamic> map) {
    final MarvelHero hero = MarvelHero(
      name: map['name'],
      id: map['id'],
      image: map['image'],
      description: map['description'],
    );
    return hero;
  }
}
