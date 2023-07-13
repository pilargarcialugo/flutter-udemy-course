import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color.fromRGBO(231, 111, 81, 1),
      unselectedItemColor: Colors.white,
      backgroundColor: const Color.fromRGBO(73, 80, 87, 1),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outlined),
          label: 'Info'
        ),
      ]
    );
  }
}