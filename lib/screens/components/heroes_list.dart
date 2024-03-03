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
    //TODO: SCROLL CONTROLLER DEVE SER DA INTERFACE, NÃO PODE CONVERSAR COM O BLOC.
    //TODO: Usar homeBloc.heroes, pois deve lembrar do que o gabriel falou sobre não controlar o estado do que está no bloc fora do bloc, ou seja, as listas de herois não devem ser atualizadas no controller, e sim dentro do bloc, sendo possível acessar a lista daqui, sem precisar do estado, apenas do bloc. apagar a oldList
    final homeBloc =
        context.watch<HomeBloc>(); //TODO: CHAMAR FUNÇÃO DE CARREGAR HEROIS.
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return CustomScrollView(
            controller: homeBloc.scrollController,
            slivers: [
              SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(heroes: homeBloc.heroes, index: index);
                },
                itemCount: homeBloc.heroes.length,
              ),
              homeBloc.isFirstFetch
                  ? const SliverFillRemaining(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 133, 22, 22),
                      )),
                    )
                  : const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 133, 22, 22),
                          ),
                        ),
                      ),
                    )
            ],
          );
        } else if (state is HomeSuccessState) {
          return CustomScrollView(
              controller: homeBloc.scrollController,
              slivers: [
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return HeroCard(heroes: homeBloc.heroes, index: index);
                  },
                  itemCount: homeBloc.heroes.length,
                ),
              ]);
        } else if (state is HomeErrorState) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Center(
                  child: Text(state.errorMessage),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
