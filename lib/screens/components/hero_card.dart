import 'package:flutter/material.dart';
import 'package:marvel_app/domain/models/marvel_hero.dart';
import 'package:marvel_app/utils/constants/routes.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.hero});
  final MarvelHero hero;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        color: const Color.fromARGB(255, 133, 22, 22),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shadowColor: Colors.black,
        child: Ink(
          height: 125,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.pushNamed(context, Routes.details, arguments: hero),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    hero.image,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      hero.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        hero.id.toString().padLeft(8, '#'),
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
