import 'package:flutter/material.dart';
import 'list_page.dart';
import 'history_page.dart';
import 'add_game_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ListPage(),
    const AddGamePage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF171A21),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}