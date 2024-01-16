import 'package:flutter/material.dart';

class CustomDialogAddIngredients extends StatefulWidget {
  final Function(String) onIngredientAdded;

  const CustomDialogAddIngredients({
    super.key,
    required this.onIngredientAdded,
  });

  @override
  State<CustomDialogAddIngredients> createState() =>
      _CustomDialogAddIngredientsState();
}

class _CustomDialogAddIngredientsState
    extends State<CustomDialogAddIngredients> {
  final TextEditingController _ingredientController = TextEditingController();
  bool isAddButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _ingredientController.addListener(_checkTextField);
  }

  void _checkTextField() {
    setState(() {
      isAddButtonEnabled = _ingredientController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber.shade100,
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Nuevo Ingrediente',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _ingredientController,
            cursorColor: Colors.amber.shade700,
            decoration: const InputDecoration(
              labelText: 'Escribe el ingrediente',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                ),
                onPressed: isAddButtonEnabled
                    ? () {
                        String ingredient = _ingredientController.text;
                        widget.onIngredientAdded(ingredient);
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text(
                  'Agregar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }
}
