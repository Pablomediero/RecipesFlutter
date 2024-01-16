import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receptom/di/app_modules.dart';
import 'package:receptom/model/ingredient.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';
import 'package:receptom/presentation/view/viewmodel/chatgpt_view_mode.dart';
import 'package:receptom/presentation/widgets/custom_dialog_add_ingredient.dart';
import 'package:receptom/presentation/widgets/ingredient_list_row.dart';

class IngredientsList extends StatefulWidget {
  const IngredientsList({super.key});

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  final ChatgptViewModel _chatgptViewModel = inject<ChatgptViewModel>();

  final List<Ingredient> ingredientsList = [];

  void _addIngredientToList(String nameIngredient) {
    setState(() {
      ingredientsList.add(Ingredient(name: nameIngredient));
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredientsList.removeAt(index);
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
              "Tabla de ingredientes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 360,
            height: 300,
            child: Center(
              child: ingredientsList.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                            "Lista vacia, pulsa en el botón 'Añadir' para agregar tantos ingredientes como quieras y posteriormente en el botón 'Buscar'.",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemExtent: 40.0,
                        itemCount: ingredientsList.length,
                        itemBuilder: (context, index) {
                          final item = ingredientsList[index];
                          return ListTile(
                            title: (IngredientListRow(
                              ingredientName: item.name,
                              onRemove: () {
                                _removeIngredient(index);
                              },
                            )),
                          );
                        },
                      ),
                    ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'btn_buscar',
                  onPressed: () {
                    if (ingredientsList.isNotEmpty) {
                      context.push(NavigationRoutes.INGREDIENTS_DETAIL,
                          extra: ingredientsList);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                            child: Text(
                                'Primero añade algún ingrediente a la lista')),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  label: const Text('Buscar'),
                  icon: const Icon(Icons.search),
                  backgroundColor: Colors.amber.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag: 'btn_add',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogAddIngredients(
                            onIngredientAdded: _addIngredientToList,
                          );
                        });
                  },
                  label: const Text('Añadir'),
                  icon: const Icon(Icons.add_shopping_cart_outlined),
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
      ),
    ));
  }
}
