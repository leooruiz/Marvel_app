import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/business/bloc/home_bloc/home_bloc.dart';
import '../../domain/business/bloc/home_bloc/home_events.dart';
import '../../domain/business/bloc/home_bloc/home_states.dart';
import 'hero_card.dart';

class HeroesListPage extends StatefulWidget {
  const HeroesListPage({super.key});

  @override
  State<HeroesListPage> createState() => _HeroesListPageState();
}

class _HeroesListPageState extends State<HeroesListPage> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    //TODO: SCROLL CONTROLLER DEVE SER DA INTERFACE, BLOC NÃO PODE SABER DA INTERFACE.
    //TODO: Usar homeBloc.heroes, pois deve lembrar do que o gabriel falou sobre não controlar o estado do que está no bloc fora do bloc, ou seja, as listas de herois não devem ser atualizadas no controller, e sim dentro do bloc, sendo possível acessar a lista daqui, sem precisar do estado, apenas do bloc. apagar a oldList
    final homeBloc =
        context.watch<HomeBloc>(); //TODO: CHAMAR FUNÇÃO DE CARREGAR HEROIS.
    Future<void> scrollListener() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !homeBloc.isLoading) {
        homeBloc.add(HomeLoadEvent());
      }
    }

    scrollController.addListener(scrollListener);
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(hero: homeBloc.heroes[index]);
                },
                itemCount: homeBloc.heroes.length,
              ),
              if (homeBloc.isFirstFetch)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        }
        if (state is HomeSuccessState) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(hero: homeBloc.heroes[index]);
                },
                itemCount: homeBloc.heroes.length,
              ),
            ],
          );
        }
        if (state is HomeErrorState) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Center(
                  child: Text(state.errorMessage),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
