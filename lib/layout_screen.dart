import 'package:flutter/material.dart';
import 'package:zyptopulse/screens/favorites_screen.dart';
import 'package:zyptopulse/screens/home_screen.dart';

import 'widgets/navbar_widget.dart';


class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {


  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MarketsStreamScreen(),

    // ServiceSelectionScreen(),
    FavoritesScreen(),
    FavoritesScreen(),
    FavoritesScreen(),
    FavoritesScreen(),
    // RequestServiceScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_selectedIndex],
      bottomNavigationBar: NavBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}