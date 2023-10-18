import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lean_scale_food_app/models/food/meal_model.dart';
import 'package:lean_scale_food_app/network/food_service.dart';
import 'package:lean_scale_food_app/utils/constants.dart';

class FoodListProvider extends ChangeNotifier {
  final _foodService = FoodService();
  final _favouriteBox = Hive.box(Constants.favouriteBoxIdentifier);
  final _basketBox = Hive.box(Constants.basketBox);
  bool isLoading = false;

  final List<MealModel> _meals = [];
  final List<MealModel> _favouriteMeals = [];
  final List<MealModel> _foodBasket = [];
  int basketQuantity = 0;

  List<MealModel> get meals => _meals;
  List<MealModel> get favouriteMeals => _favouriteMeals;
  List<MealModel> get foodBasket => _foodBasket;

  void getMeals(String categoryName) async {
    isLoading = true;
    notifyListeners();
    _meals.clear();
    var response = await _foodService.getMeals(categoryName);
    if (response != null) {
      for (var element in response) {
        _meals.add(element);
      }
      for (var item in _foodBasket) {
        //for changing foodBasket : if they are in the basket we update the item
        if (_meals.any((element) => item.idMeal == element.idMeal)) {
          var myMeal =
              _meals.firstWhere((element) => item.idMeal == element.idMeal);
          var index = _meals.indexOf(myMeal);
          _meals.removeAt(index);
          _meals.insert(index, item);
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void getFavouriteMeals() async {
    if (_favouriteBox.values.isNotEmpty) {
      for (var element in _favouriteBox.values) {
        var meal =
            MealModel.fromMap(element); //get map and turn it into a model
        _favouriteMeals.add(meal);
      }
    }
    notifyListeners();
  }

  void getBasketMeals() async {
    if (_basketBox.values.isNotEmpty) {
      for (var element in _basketBox.values) {
        var meal =
            MealModel.fromMap(element); //get map and turn it into a model
        _foodBasket.add(meal);
      }
    }
    updateQuantity();
    notifyListeners();
  }

  void addMealToBasket(MealModel meal) async {
    if (!isExist(_foodBasket, meal)) {
      meal.quantity++;
      _foodBasket.add(meal);

      var basketAsMap = _foodBasket.map((e) => e.toJson()).toList();
      for (var item in basketAsMap) {
        await _basketBox.put(item['idMeal'], item);
      }
      updateQuantity();
    }
    notifyListeners();
  }

  void increaseQuantity(MealModel meal) async {
    var myMeal =
        _foodBasket.firstWhere((element) => meal.idMeal == element.idMeal);
    myMeal.quantity++;
    await _basketBox.clear();
    var basketAsMap = _foodBasket.map((e) => e.toJson()).toList();
    for (var item in basketAsMap) {
      await _basketBox.put(item['idMeal'], item);
    }
    updateQuantity();

    notifyListeners();
  }

  void decreaseQuantity(MealModel meal) async {
    if (meal.quantity >= 1) {
      var myMeal =
          _foodBasket.firstWhere((element) => meal.idMeal == element.idMeal);
      myMeal.quantity--;
      if (myMeal.quantity == 0) {
        _foodBasket.removeWhere((element) => element.idMeal == meal.idMeal);
      }
      await _basketBox.clear();
      var basketAsMap = _foodBasket.map((e) => e.toJson()).toList();
      for (var item in basketAsMap) {
        await _basketBox.put(item['idMeal'], item);
      }
      updateQuantity();
    }
    notifyListeners();
  }

  void favouriteButtonPressed(MealModel meal) async {
    if (isExist(_favouriteMeals, meal)) {
      //remove meal from favourites
      _favouriteMeals.removeWhere((element) => element.idMeal == meal.idMeal);
      notifyListeners();
      await _favouriteBox.clear();
      var favouritesAsMap = _favouriteMeals.map((e) => e.toJson()).toList();
      for (var item in favouritesAsMap) {
        await _favouriteBox.put(item['idMeal'], item);
      }
    } else {
      //add meal to favourites
      _favouriteMeals.add(meal);

      notifyListeners();
      var favouritesAsMap = _favouriteMeals.map((e) => e.toJson()).toList();
      for (var item in favouritesAsMap) {
        await _favouriteBox.put(item['idMeal'], item);
      }
    }
  }

  bool isExist(List<MealModel> mealList, MealModel meal) {
    final isExist = mealList.any((element) => element.idMeal == meal.idMeal);
    return isExist;
  }

  void updateQuantity() {
    basketQuantity = 0;
    for (var element in _foodBasket) {
      basketQuantity += element.quantity;
    }
    notifyListeners();
  }

  void clearAllBasket() {
    _foodBasket.clear();
    _basketBox.clear();
  }
}
