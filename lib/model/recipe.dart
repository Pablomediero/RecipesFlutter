import 'package:receptom/model/ingredient.dart';

class Recipe {
  int? id;
  late String name;
  late List<Ingredient> ingredients;
  late String instructions;
  late int serving;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.serving,
  });
  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsList = [];
    if (json['ingredients'] != null) {
      json['ingredients'].forEach((ingredient) {
        ingredientsList.add(Ingredient.fromJson(ingredient));
      });
    }

    return Recipe(
      id: json['id'],
      name: json['name'],
      ingredients: ingredientsList,
      instructions: json['instructions'],
      serving: json['serving'],
    );
  }
}
