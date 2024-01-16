import 'dart:async';

import 'package:receptom/domain/recipe_repository.dart';
import 'package:receptom/model/recipe.dart';
import 'package:receptom/presentation/base/base_view_model.dart';
import 'package:receptom/presentation/model/resource_state.dart';

class RecipeViewModel extends BaseViewModel {
  final RecipeRepository _recipeRepository;

  final StreamController<ResourceState<List<Recipe>>> getAllRecipesState =
      StreamController.broadcast();
  final StreamController<ResourceState<Recipe>> getRecipeState =
      StreamController.broadcast();
  final StreamController<void> addRecipeState = StreamController.broadcast();
  final StreamController<void> deleteRecipeState = StreamController.broadcast();

  RecipeViewModel(this._recipeRepository);

  void fetchAddRecipe(Recipe recipe) {
    addRecipeState.add(ResourceState.loading());

    _recipeRepository
        .insertRecipe(recipe)
        .then((_) => addRecipeState.add(ResourceState.success(null)))
        .catchError((error) => addRecipeState.add(ResourceState.error(error)));
  }

  void fetchDeleteRecipe(Recipe recipe) {
    deleteRecipeState.add(ResourceState.loading());

    _recipeRepository
        .deleteRecipe(recipe)
        .then((_) => deleteRecipeState.add(null))
        .catchError(
            (error) => deleteRecipeState.add(ResourceState.error(error)));
  }

  void fetchGetRecipe(int idRecipe) {
    getRecipeState.add(ResourceState.loading());

    _recipeRepository
        .getRecipe(idRecipe)
        .then((value) => getRecipeState.add(ResourceState.success(value)))
        .catchError((error) => getRecipeState.add(ResourceState.error(error)));
  }

  void fetchGetAllRecipes() {
    getAllRecipesState.add(ResourceState.loading());

    _recipeRepository
        .getAllRecipe()
        .then((value) => getAllRecipesState.add(ResourceState.success(value)))
        .catchError(
            (error) => getAllRecipesState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    getAllRecipesState.close();
    getRecipeState.close();
    addRecipeState.close();
    deleteRecipeState.close();
  }
}
