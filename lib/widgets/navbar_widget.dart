import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      iconSize: 30,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF2DCC70), // Green for selected items
      unselectedItemColor: Colors.white, // White for unselected items
      backgroundColor: Colors.black, // Black background for the nav bar
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Markets"),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favourites",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: "Wallet",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Trades"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
