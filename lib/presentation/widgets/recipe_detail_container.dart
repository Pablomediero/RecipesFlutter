import 'package:flutter/material.dart';

class RecipeDetailContainer extends StatelessWidget {
  final String titleInfo;
  final String contentInfo;
  final String descInfo;
  const RecipeDetailContainer(
      {super.key,
      required this.contentInfo,
      required this.descInfo,
      required this.titleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(titleInfo,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(descInfo,
                style: const TextStyle(fontStyle: FontStyle.italic)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    contentInfo,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
