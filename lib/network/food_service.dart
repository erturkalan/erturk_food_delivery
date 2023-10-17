import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:lean_scale_food_app/models/categories/categories_response.dart';
import 'package:lean_scale_food_app/models/categories/category_model.dart';
import 'package:lean_scale_food_app/models/food/meal_model.dart';
import 'package:lean_scale_food_app/models/food/meals_response.dart';
import 'package:lean_scale_food_app/network/service_base.dart';
import 'package:lean_scale_food_app/utils/constants.dart';

class FoodService extends ServiceBase {
  Future<List<CategoryModel>?> getCategories() async {
    try {
      var response = await apiService.get(
          Constants.baseUrl, '/api/json/v1/1/categories.php');

      var categoriesResponse =
          CategoriesResponse.fromJson(jsonDecode(response));
      return categoriesResponse.categories;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<MealModel>?> getMeals(String categoryName) async {
    var parameters = <String, dynamic>{};
    parameters['c'] = categoryName;
    try {
      var response = await apiService.get(
          Constants.baseUrl, '/api/json/v1/1/filter.php',
          parameters: parameters);

      var mealsResponse = MealsResponse.fromJson(jsonDecode(response));
      return mealsResponse.meals;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
