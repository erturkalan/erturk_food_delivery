import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lean_scale_food_app/models/food/meal_model.dart';
import 'package:lean_scale_food_app/network/food_service.dart';
import 'package:lean_scale_food_app/utils/constants.dart';

class FoodListProvider extends ChangeNotifier {
  final _foodService = FoodService();
  final favouriteBox = Hive.box(Constants.favouriteBoxIdentifier);
  final quantityBox = Hive.box(Constants.quantity);

  List<MealModel> _meals = [];
  final List<MealModel> _favouriteMeals = [];
  final List<MealModel> _foodBasket = [];

  bool isLoading = false;
  List<MealModel> get meals => _meals;
  List<MealModel> get favouriteMeals => _favouriteMeals;
  List<MealModel> get foodBasket => _foodBasket;

  void getMeals(String categoryName) async {
    isLoading = true;
    notifyListeners();
    meals.clear();
    var response = await _foodService.getMeals(categoryName);
    if (response != null) {
      for (var element in response) {
        element.quantity = quantityBox.get(element.idMeal) ??
            0; //caching quantities of the meals like how many are in the basket
        meals.add(element);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void getFavouriteMeals() async {
    if (favouriteBox.values.isNotEmpty) {
      for (var element in favouriteBox.values) {
        var meal =
            MealModel.fromMap(element); //get map and turn it into a model
        _favouriteMeals.add(meal);
      }
    }
    notifyListeners();
  }

  void addMealToBasket(MealModel meal) {
    if (!isExist(_foodBasket, meal)) {
      _foodBasket.add(meal);
      meal.quantity++;
      quantityBox.put(meal.idMeal, meal.quantity);
    }

    notifyListeners();
  }

  void increaseQuantity(MealModel meal) {
    meal.quantity++;
    quantityBox.put(meal.idMeal, meal.quantity);

    notifyListeners();
  }

  void decreaseQuantity(MealModel meal) {
    if (meal.quantity >= 1) {
      meal.quantity--;
      quantityBox.put(meal.idMeal, meal.quantity);
      if (meal.quantity == 0) {
        _foodBasket.removeWhere((element) => element.idMeal == meal.idMeal);
      }
    }
    notifyListeners();
  }

  void favouriteButtonPressed(MealModel meal) async {
    if (isExist(_favouriteMeals, meal)) {
      //remove meal from favourites
      _favouriteMeals.removeWhere((element) => element.idMeal == meal.idMeal);
      notifyListeners();
      await favouriteBox.clear();
      var favouritesAsMap = _favouriteMeals.map((e) => e.toJson()).toList();
      for (var item in favouritesAsMap) {
        await favouriteBox.put(item['idMeal'], item);
      }
    } else {
      //add meal to favourites
      _favouriteMeals.add(meal);

      notifyListeners();
      var favouritesAsMap = _favouriteMeals.map((e) => e.toJson()).toList();
      for (var item in favouritesAsMap) {
        await favouriteBox.put(item['idMeal'], item);
      }
    }
  }

  bool isExist(List<MealModel> mealList, MealModel meal) {
    final isExist = mealList.any((element) => element.idMeal == meal.idMeal);
    return isExist;
  }

  void clearAllBasket() {}
}
