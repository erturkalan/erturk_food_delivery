import 'package:lean_scale_food_app/models/food/meal_model.dart';

class MealsResponse {
  List<MealModel>? meals;

  MealsResponse({this.meals});

  MealsResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <MealModel>[];
      json['meals'].forEach((v) {
        meals!.add(MealModel.fromJson(v));
      });
    }
  }
}
