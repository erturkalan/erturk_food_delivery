import 'package:lean_scale_food_app/models/categories/category_model.dart';

class CategoriesResponse {
  List<CategoryModel>? categories;

  CategoriesResponse({this.categories});
  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
  }
}
