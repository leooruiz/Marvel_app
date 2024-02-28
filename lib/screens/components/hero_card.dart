import 'package:flutter/material.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/screens/details.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.heroes, required this.index});
  final List<MarvelHero> heroes;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        color: Color.fromARGB(255, 133, 22, 22),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shadowColor: Colors.black,
        child: Ink(
          height: 100,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.pushNamed(context, Routes.details, arguments: heroes[index]),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    heroes[index].image!,
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      heroes[index].name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        heroes[index].id.toString().padLeft(8, '#'),
                        style: const TextStyle(
                          color: Color.fromARGB(130, 255, 255, 255),
                        ),
                      ),
                    ],
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
