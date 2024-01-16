import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receptom/di/app_modules.dart';
import 'package:receptom/model/recipe.dart';
import 'package:receptom/presentation/model/resource_state.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';
import 'package:receptom/presentation/provider/control_state.dart';
import 'package:receptom/presentation/view/viewmodel/recipe_view_model.dart';
import 'package:receptom/presentation/widgets/recipe_list._row.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> with RouteAware {
  List<Recipe> recipeList = [];
  final RecipeViewModel _recipeViewModel = inject<RecipeViewModel>();

  void initState() {
    super.initState();
    _loadRecipes();
    Provider.of<MiProvider>(context, listen: false)
        .addListener(_onMiProviderStateChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    _loadRecipes();
  }

  void _onMiProviderStateChanged() {
    if (Provider.of<MiProvider>(context, listen: false).myState) {
      _loadRecipes();
      Provider.of<MiProvider>(context, listen: false).refreshWidgetState(false);
    }
  }

  _loadRecipes() async {
    _recipeViewModel.fetchGetAllRecipes();
    _recipeViewModel.getAllRecipesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.SUCCESS:
          setState(() {
            recipeList = List.from(state.data!);
          });
          break;
        case Status.ERROR:
          print("Ha ocurrido un error: $state.exception");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Recetas almacenadas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: recipeList.isEmpty
                  ? const Text("Aún no tienes recetas guardadas")
                  : const Text(
                      "Estas son tus recetas guardadas",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 300,
                height: 350,
                child: Center(
                  child: recipeList.isEmpty
                      ? const Text("Lista vacia",
                          style: TextStyle(fontStyle: FontStyle.italic))
                      : Scrollbar(
                          child: ListView.builder(
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              final item = recipeList[index];
                              return ListTile(
                                title: RecipeListRow(
                                    recipeName: item.name, recipeId: item.id!),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(11.0),
              child: Text(
                "Puedes pulsar en la receta para poder ver más",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<MiProvider>(context, listen: false)
        .removeListener(_onMiProviderStateChanged);
    _recipeViewModel.dispose();
    super.dispose();
  }
}
