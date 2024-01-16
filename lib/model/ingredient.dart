class Ingredient {
  late int id;
  late int idRecipe;
  late String name;

  Ingredient({
    this.id = 0,
    this.idRecipe = 0,
    required this.name,
  });
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      idRecipe: json['idRecipe'],
      name: json['name'],
    );
  }
}
