import 'package:receptom/model/ingredient.dart';

class Order {
  final List<Ingredient> ingredients;
  final bool mode;
  final String recipeName;

  Order(
      {required this.ingredients,
      required this.mode,
      required this.recipeName});
}
