import 'package:flutter/material.dart';
import 'package:mapproject/screens/account.dart';
import 'package:mapproject/screens/cord.dart';
import 'package:mapproject/screens/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //setting current index
  int _currentIndex = 0;

  //array of pages
  List pages = const [
    HomePage(),
    MapPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _currentIndex,
        onTap: ((value) => setState(() {
              _currentIndex = value;
            })),
      ),
    );
  }
}
