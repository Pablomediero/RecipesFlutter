import 'dart:async';
import 'package:floor/floor.dart';
import 'package:receptom/data/cache/recipe/dao/recipe_dao.dart';
import 'package:receptom/data/cache/recipe/model/cache_recipe.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [CacheRecipe])
abstract class AppDatabase extends FloorDatabase {
  RecipeDao get recipeDao;
}
