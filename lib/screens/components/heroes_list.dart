import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_states.dart';
import 'package:marvel_app/screens/components/hero_card.dart';

class HeroesList extends StatelessWidget {
  const HeroesList({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final homeBloc =
        context.watch<HomeBloc>(); //TODO: CHAMAR FUNÇÃO DE CARREGAR HEROIS.
    return CustomScrollView(
      controller: homeBloc.scrollController,
      slivers: [
        BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
          if (state is HomeLoadingState && homeBloc.isFirstFetch) {
            print('É A PRIMEIRA VEZ CARREGANDO HERÓIS');
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 179, 0, 0),
                ),
              ),
            );
          } else if (state is HomeLoadingState && !homeBloc.isFirstFetch) {
            print('NÃO É A PRIMEIRA VEZ CARREGANDO HERÓIS');
            return SliverList.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    HeroCard(
                        heroes: homeBloc.oldList,
                        index:
                            index), //TODO: Usar homeBloc.heroes, pois deve lembrar do que o gabriel falou sobre não controlar o estado do que está no bloc fora do bloc, ou seja, as listas de herois não devem ser atualizadas no controller, e sim dentro do bloc, sendo possível acessar a lista daqui, sem precisar do estado, apenas do bloc. apagar a oldList
                  ],
                );
              },
              itemCount: homeBloc.oldList.length,
            );
          } else if (state is HomeSuccessState) {
            return SliverList.builder(
              itemBuilder: (context, index) {
                return HeroCard(heroes: state.heroes, index: index);
              },
              itemCount: state.heroes.length,
            );
          } else if (state is HomeErrorState) {
            return SliverFillRemaining(
                child: Center(child: Text(state.errorMessage)));
          } else {
            return const SizedBox.shrink();
          }
        }),
        homeBloc.isFirstFetch
            ? SliverToBoxAdapter(
                child: SizedBox.shrink(),
              )
            : SliverToBoxAdapter(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 179, 0, 0),
                )),
              )
      ],
    );
  }
}
