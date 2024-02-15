import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/data/bloc/home_bloc/home_list_bloc.dart';
import 'package:marvel_app/data/bloc/home_bloc/home_list_states.dart';
import 'package:marvel_app/screens/details.dart';

class HeroesList extends StatelessWidget {
  const HeroesList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<HomeListBloc, HomeListStates>(builder: (context, state) {
          context.read<HomeListBloc>();
          if (state is HomeLoadingState) {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeSuccessState) {
            return SliverList.builder(
              itemBuilder: (context, index) {
                return state.heroes[index].image != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Ink(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    hero: state.heroes[index],
                                  ),
                                ),
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Text(state.heroes[index].name.toString()),
                                    Text(state.heroes[index].id.toString()),
                                    Text(state.heroes[index].description
                                        .toString()),
                                    Image.network(state.heroes[index].image!),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(
                        child: Center(
                            child: SizedBox(
                        child: Text('TESTING IF ITS NULL'),
                      )));
              },
              itemCount: state.heroes.length,
            );
          } else if (state is HomeErrorState) {
            return const SliverToBoxAdapter(child: Text('Erro'));
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
