import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/business/bloc/theme_bloc/theme_bloc.dart';
import '../domain/business/bloc/theme_bloc/theme_states.dart';
import '../themes/app_colors.dart';
import '../utils/constants/wordings.dart';
import 'components/heroes_list_page.dart';
import 'components/home_drawer.dart';
import 'favorites_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Widget> _pages = <Widget>[
    HeroesListPage(),
    FavoritesScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state is ThemeLightState ? AppColors.white : AppColors.dark,
          drawer: HomeDrawer(
            state: state,
            themeBloc: themeBloc,
          ),
          appBar: AppBar(
            title: Text(
              Wordings.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: _pages.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: Wordings.heroes,
                icon: Icon(
                  Icons.list,
                ),
                label: Wordings.heroes,
              ),
              BottomNavigationBarItem(
                tooltip: Wordings.favorites,
                icon: Icon(
                  Icons.favorite,
                ),
                label: Wordings.favorites,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
