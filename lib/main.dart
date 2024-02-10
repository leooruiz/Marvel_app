import 'package:flutter/material.dart';
import 'package:marvel_app/screens/details.dart';
import 'package:marvel_app/screens/favorites.dart';
import 'package:marvel_app/screens/home.dart';
import 'package:marvel_app/utils/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.home: (context) => const Home(),
        Routes.details: (context) => const Details(),
        Routes.favorites: (context) => const Favorites(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: Routes.home,
      home: const Home(),
    );
  }
}
