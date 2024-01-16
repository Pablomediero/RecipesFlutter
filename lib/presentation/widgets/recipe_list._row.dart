import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';

class RecipeListRow extends StatelessWidget {
  final String recipeName;
  final int recipeId;
  const RecipeListRow(
      {super.key, required this.recipeName, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(NavigationRoutes.RECIPES_DETAIL, extra: recipeId);
      },
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipeName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.amber.shade700,
            )
          ],
        ),
      )),
    );
  }
}
