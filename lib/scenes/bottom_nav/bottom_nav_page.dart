import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/basket/basket_screen.dart';
import 'package:lean_scale_food_app/scenes/favourite/favourite_screen.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_provider.dart';
import 'package:lean_scale_food_app/scenes/home/home_screen.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  Color changeColor(int index) {
    switch (index) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.indigo;
      case 2:
        return Colors.yellow.shade900;
      default:
        return Colors.redAccent;
    }
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodListProvider>(
        builder: ((context, foodListProvider, child) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          onTap: onTap,
          currentIndex: _currentIndex,
          activeColor: changeColor(_currentIndex),
          inactiveColor: Colors.grey.withOpacity(0.6),
          items: [
            const BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.food_bank_rounded)),
            BottomNavigationBarItem(
                label: "Basket",
                icon: foodListProvider.basketQuantity == 0
                    ? const Icon(Icons.shopping_basket_rounded)
                    : Stack(
                        children: [
                          const Icon(Icons.shopping_basket_rounded),
                          Positioned(
                            top: -1,
                            right: 0,
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 0.1,
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  foodListProvider.basketQuantity.toString(),
                                  style: const TextStyle(
                                      color: Colors.indigo, fontSize: 13),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
            const BottomNavigationBarItem(
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
    }));
  }
}
