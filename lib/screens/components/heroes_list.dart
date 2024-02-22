import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_states.dart';
import 'package:marvel_app/screens/components/hero_card.dart';

class HeroesList extends StatelessWidget {
  const HeroesList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
          if (state is HomeLoadingState) {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 179, 0, 0),
                ),
              ),
            );
          } else if (state is HomeSuccessState) {
            return SliverList.builder(
              itemBuilder: (context, index) {
                return state.heroes[index].image != null
                    ? HeroCard(heroes: state.heroes, index: index)
                    : const SliverToBoxAdapter(
                        child: Center(
                            child: SizedBox(
                        child: Text('TESTING IF ITS NULL'),
                      )));
              },
              itemCount: state.heroes.length,
            );
          } else if (state is HomeErrorState) {
            return SliverFillRemaining(
                child: Center(child: Text(state.errorMessage)));
          } else {
            return const SliverToBoxAdapter(
                child: Center(
              child: Text('Nothing'),
            ));
          }
        })
      ],
    );
  }
}
