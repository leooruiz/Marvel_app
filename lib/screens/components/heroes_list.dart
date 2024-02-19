import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_bloc.dart';
import 'package:marvel_app/domain/business/bloc/home_bloc/home_list_states.dart';
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
                            height: 100,
                            width: MediaQuery.of(context).size.width / 1.2,
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
                                color: Color.fromARGB(255, 145, 16, 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(state.heroes[index].image!,
                                        fit: BoxFit.cover),
                                    Text(state.heroes[index].name.toString()),
                                    Text(state.heroes[index].id.toString()),
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
