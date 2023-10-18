class MealModel {
  String? idMeal;
  String? strMeal;
  String? strMealThumb;
  int quantity = 0;

  MealModel({this.idMeal, this.strMeal, this.strMealThumb, this.quantity = 0});

  MealModel.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  factory MealModel.fromMap(Map<dynamic, dynamic> map) {
    return MealModel(
      idMeal: map['idMeal'],
      strMeal: map['strMeal'],
      strMealThumb: map['strMealThumb'],
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['quantity'] = quantity;

    return data;
  }
}
