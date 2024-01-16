import 'package:flutter/material.dart';

class IngredientListRow extends StatelessWidget {
  final String ingredientName;
  final VoidCallback onRemove;

  const IngredientListRow(
      {super.key, required this.ingredientName, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ingredientName),
          ),
          const Spacer(),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close),
          )
        ],
      ),
    );
  }
}
