import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';

class CustomDialogInfo extends StatelessWidget {
  final bool mode;
  final String titleDialog;
  final String descDialog;
  final String imgDialog;
  final VoidCallback? onClicked;

  const CustomDialogInfo({
    Key? key,
    required this.mode,
    required this.titleDialog,
    required this.descDialog,
    required this.imgDialog,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber.shade100,
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleDialog,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            descDialog,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgDialog),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          mode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onClicked,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                      ),
                      child: const Text(
                        'Si',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.push(NavigationRoutes.INGREDIENTS_LIST);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                      ),
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
