import 'package:receptom/data/cache/recipe/cache/recipe_local_impl.dart';
import 'package:receptom/domain/recipe_repository.dart';
import 'package:receptom/model/recipe.dart';

class RecipeDataImpl extends RecipeRepository {
  RecipeDataImpl(this._localImpl);
  final RecipeLocalImpl _localImpl;

  @override
  Future<void> deleteRecipe(Recipe recipe) async {
    _localImpl.deleteRecipe(recipe);
  }

  @override
  Future<List<Recipe>> getAllRecipe() async {
    return _localImpl.getAllRecipe();
  }

  @override
  Future<Recipe> getRecipe(int idRecipe) async {
    return _localImpl.getRecipe(idRecipe);
  }

  @override
  Future<void> insertRecipe(Recipe recipe) async {
    _localImpl.insertRecipe(recipe);
  }
}
