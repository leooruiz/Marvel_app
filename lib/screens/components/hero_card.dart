import 'package:flutter/material.dart';

import '../../domain/models/marvel_hero.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants/routes.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({required this.hero, super.key});
  final MarvelHero hero;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        color: AppColors.redCard,
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shadowColor: AppColors.dark,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () =>
                Navigator.pushNamed(context, Routes.details, arguments: hero),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    hero.image,
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      hero.name,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        hero.id.toString().padLeft(8, '#'),
                        style: const TextStyle(
                          color: AppColors.greyId,
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
