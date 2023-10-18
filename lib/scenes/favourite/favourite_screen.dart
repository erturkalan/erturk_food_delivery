import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_provider.dart';
import 'package:lean_scale_food_app/utils/constants.dart';
import 'package:lean_scale_food_app/widgets/custom_food_box.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodListProvider>(
        builder: ((context, foodListProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          title: const Text(
            Constants.favouritePageTitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
          ),
          elevation: 0.5,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.5),
                    itemCount: foodListProvider.favouriteMeals.length,
                    itemBuilder: (context, index) {
                      var meal = foodListProvider.favouriteMeals[index];
                      return CustomFoodBox(
                        onPressed: () => null,
                        image: meal.strMealThumb != null
                            ? meal.strMealThumb!
                            : null,
                        name: meal.strMeal != null ? meal.strMeal! : "N/A",
                        isFoodList: true,
                        isFavouriteActive: foodListProvider.isExist(
                            foodListProvider.favouriteMeals, meal),
                        favouriteButtonPressed: () =>
                            foodListProvider.favouriteButtonPressed(meal),
                        addToBasketButtonPressed: () =>
                            foodListProvider.addMealToBasket(meal),
                        isInBasket: foodListProvider.isExist(
                            foodListProvider.foodBasket, meal),
                        decreasePressed: () =>
                            foodListProvider.decreaseQuantity(meal),
                        increasedPressed: () =>
                            foodListProvider.increaseQuantity(meal),
                        quantity: meal.quantity,
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
