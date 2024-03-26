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
          width: 100,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () =>
                Navigator.pushNamed(context, Routes.details, arguments: hero),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      hero.image,
                      fit: BoxFit.cover,
                      height: 120,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              hero.id.toString().padLeft(8, '#'),
                              style: const TextStyle(
                                color: AppColors.greyId,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: Center(
                                child: Text(
                                  hero.name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                        ],
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
