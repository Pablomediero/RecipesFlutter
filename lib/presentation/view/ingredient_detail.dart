import 'package:flutter/material.dart';
import 'package:receptom/di/app_modules.dart';
import 'package:receptom/model/ingredient.dart';
import 'package:receptom/model/order.dart';
import 'package:receptom/model/recipe.dart';
import 'package:receptom/presentation/model/resource_state.dart';
import 'package:receptom/presentation/view/viewmodel/chatgpt_view_mode.dart';
import 'package:receptom/presentation/view/viewmodel/recipe_view_model.dart';
import 'package:receptom/presentation/widgets/custom_dialog_info.dart';

class IngredientDetail extends StatefulWidget {
  const IngredientDetail({super.key, required this.ingredientsListParam});
  final List<Ingredient> ingredientsListParam;
  @override
  State<IngredientDetail> createState() => _IngredientDetailState();
}

class _IngredientDetailState extends State<IngredientDetail> {
  final ChatgptViewModel _chatgptViewModel = inject<ChatgptViewModel>();
  final RecipeViewModel _recipeViewModel = inject<RecipeViewModel>();
  bool isLoading = true;
  late int idRecipe = 0;
  late String nameRecipe = '';
  late List<Ingredient> ingredientsRecipe = [];
  late String instructionsRecipe = '';
  late String servingRecipe = '';
  late Recipe recipeChatgpt = Recipe(
      id: null,
      name: nameRecipe,
      ingredients: ingredientsRecipe,
      instructions: instructionsRecipe,
      serving: int.parse(servingRecipe));

  void initState() {
    super.initState();
    _loadRecipe(true, '');
  }

  _loadRecipe(bool mode, String recipeName) {
    setState(() {
      isLoading = true;
    });
    _chatgptViewModel.fetchRecipeChatgpt(Order(
        ingredients: widget.ingredientsListParam,
        mode: mode,
        recipeName: recipeName));
    _chatgptViewModel.getChatgptResponseState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.SUCCESS:
          setState(() {
            nameRecipe = '${state.data?.name}';
            ingredientsRecipe = state.data!.ingredients;
            instructionsRecipe = '${state.data?.instructions}';
            servingRecipe = '${state.data?.serving}';
            isLoading = false;
          });

          break;
        case Status.ERROR:
          print("Ha ocurrido un error: $state.exception");
      }
    });
  }

  @override
  void dispose() {
    _chatgptViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  Text(nameRecipe,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            replacement: Container(
              width: 300,
              height: 350,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'PREPARACION: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(instructionsRecipe),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "INGREDIENTES: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(ingredientsRecipe
                        .map((ingredient) => ingredient.name)
                        .join('\n')),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "CANTIDAD: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(servingRecipe),
                  ],
                ),
              ),
            ),
            child: CircularProgressIndicator(
              color: Colors.amber.shade700,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'btn_siguiente',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogInfo(
                            mode: true,
                            titleDialog: 'Generar otra receta',
                            descDialog:
                                '¿Estás seguro de que quieres generar otra receta distinta?',
                            imgDialog: 'assets/flutter_next.png',
                            onClicked: () {
                              Navigator.of(context).pop();
                              _loadRecipe(false, nameRecipe);
                            },
                          );
                        });
                  },
                  label: const Text('Siguiente'),
                  icon: const Icon(Icons.refresh),
                  backgroundColor: Colors.amber.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag: 'btn_guardar',
                  onPressed: () {
                    _recipeViewModel.fetchAddRecipe(recipeChatgpt);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialogInfo(
                            mode: false,
                            titleDialog: 'Guardado',
                            descDialog:
                                'Acabas de guardar esta receta en tu lista.',
                            imgDialog: 'assets/flutter_ok.png',
                          );
                        });
                  },
                  label: const Text('Guardar'),
                  icon: const Icon(Icons.save_alt_rounded),
                  backgroundColor: Colors.amber.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
