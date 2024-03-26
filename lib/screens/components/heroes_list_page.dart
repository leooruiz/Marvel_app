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

    final homeBloc = context.watch<HomeBloc>();
    Future<void> scrollListener() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !homeBloc.isLoading) {
        homeBloc.add(HomeLoadNextEvent());
      }
    }

    scrollController.addListener(scrollListener);

    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return CustomScrollView(
            controller: scrollController,
            slivers: const [
              SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }
        if (state is HomeLoadingNextState) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.builder(
                itemBuilder: (context, index) {
                  return HeroCard(
                    hero: state.heroes[index],
                  );
                },
                itemCount: state.heroes.length,
              ),
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
                  return HeroCard(hero: state.heroes[index]);
                },
                itemCount: state.heroes.length,
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
