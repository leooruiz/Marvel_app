import 'package:flutter/material.dart';
import 'package:marvel_app/screens/components/heroes_list.dart';
import 'package:marvel_app/screens/favorites.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Widget> pages = <Widget>[
    HeroesList(),
    Favorites(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MARVEL Heroes',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w700),
        ),
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 179, 0, 0),
      ),
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white60,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 179, 0, 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: 'Heroes',
            icon: Icon(
              Icons.list,
            ),
            label: 'Heroes',
          ),
          BottomNavigationBarItem(
            tooltip: 'Favorites',
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
