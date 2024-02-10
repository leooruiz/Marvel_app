import 'package:flutter/material.dart';
import 'package:marvel_app/domain/models/hero.dart';

class Details extends StatelessWidget {
  const Details({super.key, this.hero});
  final MarvelHero? hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(hero!.name.toString()),
          Image.network(hero!.image.toString()),
          Text(hero!.description.toString()),
        ],
      ),
    );
  }
}
