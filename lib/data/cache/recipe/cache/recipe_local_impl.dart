import 'package:receptom/data/cache/app_database.dart';
import 'package:receptom/data/cache/recipe/mapper/recipe_cache_mapper.dart';
import 'package:receptom/model/recipe.dart';

class RecipeLocalImpl {
  final AppDatabase _database;
  RecipeLocalImpl(this._database);
  Future<void> deleteRecipe(Recipe recipe) async {
    await _database.recipeDao
        .deleteRecipe(RecipeCacheMapper.mapToCache(recipe));
  }

  Future<List<Recipe>> getAllRecipe() async {
    final allRecipes = await _database.recipeDao.getAllRecipes();
    return RecipeCacheMapper.mapListFromCache(allRecipes);
  }

  Future<Recipe> getRecipe(int idRecipe) async {
    final result = await _database.recipeDao.getRecipe(idRecipe);
    return RecipeCacheMapper.mapFromCache(result!);
  }

  Future<void> insertRecipe(Recipe recipe) async {
    await _database.recipeDao
        .insertRecipe(RecipeCacheMapper.mapToCache(recipe));
  }
}
