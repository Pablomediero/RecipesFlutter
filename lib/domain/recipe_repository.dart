import 'package:receptom/model/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getAllRecipe();
  Future<Recipe> getRecipe(int idRecipe);
  Future<void> insertRecipe(Recipe recipe);
  Future<void> deleteRecipe(Recipe recipe);
}
