import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receptom/di/app_modules.dart';
import 'package:receptom/model/ingredient.dart';
import 'package:receptom/model/recipe.dart';
import 'package:receptom/presentation/model/resource_state.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';
import 'package:receptom/presentation/view/viewmodel/recipe_view_model.dart';
import 'package:receptom/presentation/widgets/custom_dialog_info.dart';
import 'package:receptom/presentation/widgets/recipe_detail_container.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.recipeIdParam});
  final int recipeIdParam;
  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final RecipeViewModel _recipeViewModel = inject<RecipeViewModel>();
  late int idRecipe = 0;
  late String nameRecipe = '';
  late List<Ingredient> ingredientsRecipe = [];
  late String instructionsRecipe = '';
  late String servingRecipe = '';
  late Recipe recipeChatgpt = Recipe(
      id: idRecipe,
      name: nameRecipe,
      ingredients: ingredientsRecipe,
      instructions: instructionsRecipe,
      serving: int.parse(servingRecipe));

  void initState() {
    super.initState();
    _loadRecipeDetail();
  }

  _loadRecipeDetail() {
    _recipeViewModel.fetchGetRecipe(widget.recipeIdParam);

    _recipeViewModel.getRecipeState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.SUCCESS:
          setState(() {
            idRecipe = state.data!.id!;
            nameRecipe = state.data!.name;
            ingredientsRecipe = state.data!.ingredients;
            instructionsRecipe = state.data!.instructions;
            servingRecipe = state.data!.serving.toString();
          });
          break;
        case Status.ERROR:
          print("Ha ocurrido un error: $state.exception");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/iv_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FloatingActionButton(
                          heroTag: 'btn_volver',
                          backgroundColor: Colors.amber.shade100,
                          onPressed: () {
                            context.go(NavigationRoutes.RECIPES_LIST);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FloatingActionButton(
                          heroTag: 'btn_delete',
                          backgroundColor: Colors.amber.shade100,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogInfo(
                                  mode: true,
                                  titleDialog: 'Eliminar Receta',
                                  descDialog:
                                      '¿Estás seguro de que quieres eliminar esta receta?',
                                  imgDialog: 'assets/flutter_delete.png',
                                  onClicked: () {
                                    _recipeViewModel
                                        .fetchDeleteRecipe(recipeChatgpt);
                                    Navigator.of(context).pop();
                                    context.go(NavigationRoutes.RECIPES_LIST);
                                  },
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.amber.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        nameRecipe,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.amber,
                      tabs: [
                        Tab(text: 'Ingredientes'),
                        Tab(text: 'Preparación'),
                        Tab(text: 'Cantidad'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          RecipeDetailContainer(
                              titleInfo: "INGREDIENTES:",
                              descInfo:
                                  "Estos son los necesarios para realizar esta receta.",
                              contentInfo: ingredientsRecipe
                                  .map((e) => e.name)
                                  .join('\n')),
                          RecipeDetailContainer(
                              titleInfo: "PREPARACION:",
                              descInfo:
                                  "Esta es la preparación a seguir para realizar esta receta.",
                              contentInfo: instructionsRecipe),
                          RecipeDetailContainer(
                              titleInfo: "CANTIDAD:",
                              descInfo:
                                  "Esta es la cantidad determinada de personas para la receta.",
                              contentInfo: servingRecipe)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
