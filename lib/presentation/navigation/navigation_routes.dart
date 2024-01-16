import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receptom/model/ingredient.dart';
import 'package:receptom/presentation/view/home_page.dart';
import 'package:receptom/presentation/view/ingredient_detail.dart';
import 'package:receptom/presentation/view/ingredients_list.dart';
import 'package:receptom/presentation/view/recipe_detail.dart';
import 'package:receptom/presentation/view/recipes_list.dart';

class NavigationRoutes {
  static const RECIPES_LIST = '/recipelist';
  static const INGREDIENTS_LIST = '/ingredientslist';
  static const RECIPES_DETAIL = '$RECIPES_LIST/$_RECIPES_DETAIL_PATH';

  static const INGREDIENTS_DETAIL =
      '$INGREDIENTS_LIST/$_INGREDIENTS_DETAIL_PATH';

  static const _RECIPES_DETAIL_PATH = 'recipedetail';
  static const _INGREDIENTS_DETAIL_PATH = 'ingredientsdetail';
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

final GoRouter router =
    GoRouter(initialLocation: NavigationRoutes.RECIPES_LIST, observers: [
  routeObserver
], routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(
            navigationShell: navigationShell,
          ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.INGREDIENTS_LIST,
            builder: (context, state) => const IngredientsList(),
            routes: [
              GoRoute(
                path: NavigationRoutes._INGREDIENTS_DETAIL_PATH,
                builder: (context, state) => IngredientDetail(
                    ingredientsListParam: state.extra as List<Ingredient>),
              )
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.RECIPES_LIST,
            builder: (context, state) => const RecipesList(),
            routes: [
              GoRoute(
                path: NavigationRoutes._RECIPES_DETAIL_PATH,
                builder: (context, state) =>
                    RecipeDetail(recipeIdParam: state.extra as int),
              )
            ],
          ),
        ]),
      ])
]);
