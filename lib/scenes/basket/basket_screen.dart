import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/main.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_provider.dart';
import 'package:lean_scale_food_app/utils/constants.dart';
import 'package:lean_scale_food_app/widgets/basket_line_box.dart';
import 'package:lean_scale_food_app/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodListProvider>(
        builder: ((context, foodListProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            Constants.basketPageTitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (foodListProvider.basketQuantity > 0) {
                    showMyDialog(foodListProvider.clearAllBasket,
                        "Are you sure you want to delete the basket?");
                  }
                },
              ),
            )
          ],
          elevation: 0.5,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 2),
                child: ListView.builder(
                    itemCount: foodListProvider.foodBasket.length,
                    itemBuilder: (context, index) {
                      var meal = foodListProvider.foodBasket[index];
                      return BasketLineBox(
                        name: meal.strMeal != null ? meal.strMeal! : "N/A",
                        image: meal.strMealThumb != null
                            ? meal.strMealThumb!
                            : null,
                        decreasePressed: () =>
                            foodListProvider.decreaseQuantity(meal),
                        increasedPressed: () =>
                            foodListProvider.increaseQuantity(meal),
                        quantity: meal.quantity,
                        onDelete: () =>
                            foodListProvider.deleteOneLineBasket(meal),
                      );
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showMyDialog(foodListProvider.clearAllBasket,
                    "You are going to confirm the basket");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 14)),
              child: const Text(
                "Confirm Basket",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      );
    }));
  }
}

void showMyDialog(Function func, String message) {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (ctx) => CustomDialog(
            message: message,
            okText: "Yes",
            okPressed: () => func(),
            isSecondButtonAvailable: true,
            secondButtonText: "Cancel",
          ));
}
