import 'package:flutter/cupertino.dart';
import 'package:lean_scale_food_app/models/categories/category_model.dart';
import 'package:lean_scale_food_app/network/food_service.dart';

class CategoryListProvider extends ChangeNotifier {
  final _foodService = FoodService();
  List<CategoryModel> _categories = [];
  bool isLoading = false;
  List<CategoryModel> get categories => _categories;

  void getCategories() async {
    isLoading = true;
    notifyListeners();

    var response = await _foodService.getCategories();
    if (response != null) {
      _categories = response;
    }
    isLoading = false;
    notifyListeners();
  }
}
