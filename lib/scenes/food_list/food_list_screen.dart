import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_provider.dart';
import 'package:lean_scale_food_app/widgets/custom_food_box.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatefulWidget {
  final String categoryName;
  const FoodListScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FoodListProvider>(context, listen: false)
          .getMeals(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<FoodListProvider>(
        builder: ((context, foodListProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.categoryName,
            style: const TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.indigo,
              size: 30,
            ),
          ),
          elevation: 0.5,
          centerTitle: false,
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
                    itemCount: foodListProvider.meals.length,
                    itemBuilder: (context, index) => CustomFoodBox(
                          onPressed: () => null,
                          image:
                              foodListProvider.meals[index].strMealThumb != null
                                  ? foodListProvider.meals[index].strMealThumb!
                                  : null,
                          title: foodListProvider.meals[index].strMeal != null
                              ? foodListProvider.meals[index].strMeal!
                              : "N/A",
                          isFoodList: true,
                          isFavouriteActive: foodListProvider.isExist(
                              foodListProvider.favouriteMeals,
                              foodListProvider.meals[index]),
                          favouriteButtonPressed: () {
                            foodListProvider.favouriteButtonPressed(
                                foodListProvider.meals[index]);
                          },
                          addToBasketButtonPressed: () {
                            foodListProvider
                                .addMealToBasket(foodListProvider.meals[index]);
                          },
                          isInBasket: foodListProvider.isExist(
                              foodListProvider.foodBasket,
                              foodListProvider.meals[index]),
                          decreasePressed: () => foodListProvider
                              .decreaseQuantity(foodListProvider.meals[index]),
                          increasedPressed: () => foodListProvider
                              .increaseQuantity(foodListProvider.meals[index]),
                          quantity: foodListProvider.meals[index].quantity,
                        )),
              ),
            ),
          ],
        ),
      );
    })));
  }
}
