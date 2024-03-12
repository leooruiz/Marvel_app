import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/business/bloc/theme_bloc/theme_bloc.dart';
import '../domain/business/bloc/theme_bloc/theme_events.dart';
import '../domain/business/bloc/theme_bloc/theme_states.dart';
import '../themes/app_colors.dart';
import '../utils/constants/wordings.dart';
import 'components/heroes_list_page.dart';
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

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon>((states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(
        Icons.light_mode_sharp,
        color: AppColors.dark,
      );
    } else {
      return const Icon(
        Icons.dark_mode,
        color: AppColors.white,
      );
    }
  });

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state is ThemeLightState ? AppColors.white : AppColors.dark,
          drawer: Drawer(
            backgroundColor:
                state is ThemeLightState ? AppColors.white : AppColors.dark,
            width: MediaQuery.of(context).size.width / 2.2,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(
                    Wordings.settings,
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      fontWeight: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .fontWeight, //TODO: POSSO USAR NULL CHECK AQUI?
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Wordings.theme,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .fontWeight,
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: AppColors.darkRed,
                        inactiveTrackColor: AppColors.dark,
                        activeTrackColor: AppColors.darkRed,
                        thumbIcon: thumbIcon,
                        value: state is ThemeLightState,
                        onChanged: (bool value) {
                          themeBloc.add(
                            ThemeChangeEvent(
                              isLight: !value,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
