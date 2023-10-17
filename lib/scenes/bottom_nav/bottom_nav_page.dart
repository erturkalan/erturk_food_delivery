import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/basket/basket_screen.dart';
import 'package:lean_scale_food_app/scenes/favourite/favourite_screen.dart';
import 'package:lean_scale_food_app/scenes/home/home_screen.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  List pages = [
    const HomeScreen(),
    const BasketScreen(),
    const FavouriteScreen()
  ];

  int _currentIndex = 0;
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: onTap,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.food_bank_rounded)),
          BottomNavigationBarItem(
              label: "Basket", icon: Icon(Icons.shopping_basket_rounded)),
          BottomNavigationBarItem(
              label: "Favourite", icon: Icon(Icons.favorite))
        ],
      ),
    );
  }
}
