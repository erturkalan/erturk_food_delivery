import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.redAccent,
        inactiveColor: Colors.grey.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.food_bank_rounded)),
          BottomNavigationBarItem(
              label: "Basket", icon: Icon(Icons.shopping_basket_rounded)),
          BottomNavigationBarItem(
              label: "Favourite", icon: Icon(Icons.favorite))
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: HomeScreen());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: BasketScreen());
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: FavouriteScreen());
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: HomeScreen());
            });
        }
      },
    );
  }
}
