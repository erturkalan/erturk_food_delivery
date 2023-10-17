class MealModel {
  String? idMeal;
  String? strMeal;
  String? strMealThumb;

  MealModel({this.idMeal, this.strMeal, this.strMealThumb});

  MealModel.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    return data;
  }
}
