import 'package:receptom/data/cache/recipe/model/cache_recipe.dart';
import 'package:receptom/model/ingredient.dart';
import 'package:receptom/model/recipe.dart';

class RecipeCacheMapper {
  static List<Recipe> mapListFromCache(List<CacheRecipe> cacheRecipeList) {
    return cacheRecipeList
        .map((cacheRecipe) => mapFromCache(cacheRecipe))
        .toList();
  }

  static Recipe mapFromCache(CacheRecipe type) {
    return Recipe(
        id: type.id,
        name: type.name,
        ingredients: mapFromListString(type.ingredients),
        instructions: type.instructions,
        serving: type.serving);
  }

  static List<Ingredient> mapFromListString(String ingredientsString) {
    List<String> listString = ingredientsString.split('|');
    List<Ingredient> ingredientsList = [];
    for (var element in listString) {
      ingredientsList.add(Ingredient(name: element));
    }

    return ingredientsList;
  }

  static CacheRecipe mapToCache(Recipe recipe) {
    return CacheRecipe(
      recipe.id,
      recipe.name,
      mapToString(recipe.ingredients),
      recipe.instructions,
      recipe.serving,
    );
  }

  static String mapToString(List<Ingredient> ingredientList) {
    return ingredientList.map((ingredient) => ingredient.name).join('|');
  }
}
