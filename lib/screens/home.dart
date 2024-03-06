import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/theme_bloc/theme_bloc.dart';
import 'package:marvel_app/domain/business/bloc/theme_bloc/theme_events.dart';
import 'package:marvel_app/domain/business/bloc/theme_bloc/theme_states.dart';
import 'package:marvel_app/screens/components/heroes_list.dart';
import 'package:marvel_app/screens/favorites.dart';
import 'package:marvel_app/utils/constants/wordings.dart';

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
      );
    } else {
      return const Icon(
        Icons.dark_mode,
      );
    }
  });

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state is ThemeLightState
              ? Colors.white
              : const Color.fromARGB(255, 46, 46, 46),
          drawer: Drawer(
            backgroundColor: state is ThemeLightState
                ? const Color.fromARGB(235, 255, 255, 255)
                : const Color.fromARGB(248, 46, 46, 46),
            width: MediaQuery.of(context).size.width / 2.2,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(
                    Wordings.settings,
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
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
                          color: Colors.red.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ), 
                      Switch(
                        inactiveThumbColor: Colors.black,
                        activeTrackColor: Colors.black,
                        thumbIcon: thumbIcon,
                        value: state is ThemeLightState
                            ? true
                            : false, //TODO: Salvar preferencia do usuario no shared prefs
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
            foregroundColor: Colors.white,
            title: const Text(
              Wordings.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            elevation: 4,
            backgroundColor: const Color.fromARGB(255, 114, 24, 24),
          ),
          body: _pages.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white60,
            selectedItemColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 114, 24, 24),
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
