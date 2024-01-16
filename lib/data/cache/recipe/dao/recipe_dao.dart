import 'package:floor/floor.dart';
import 'package:receptom/data/cache/recipe/model/cache_recipe.dart';

@dao
abstract class RecipeDao {
  @Query('SELECT * FROM CacheRecipe')
  Future<List<CacheRecipe>> getAllRecipes();

  @Query('SELECT * FROM CacheRecipe WHERE id = :id')
  Future<CacheRecipe?> getRecipe(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertRecipe(CacheRecipe recipe);

  @delete
  Future<void> deleteRecipe(CacheRecipe recipe);
}
