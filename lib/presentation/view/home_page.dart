import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';
import 'package:receptom/presentation/provider/control_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MiProvider miProvider;

  @override
  void initState() {
    super.initState();
    miProvider = Provider.of<MiProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Receptom')),
        backgroundColor: Colors.amber.shade700,
      ),
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.amber.shade100,
        surfaceTintColor: Colors.white,
        indicatorColor: Colors.amber.shade200,
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (value) {
          if (value == 1) {
            miProvider.refreshWidgetState(true);
          }
          widget.navigationShell.goBranch(value,
              initialLocation: value == widget.navigationShell.currentIndex);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: "Buscar",
          ),
          NavigationDestination(
            icon: Icon(Icons.lunch_dining_outlined),
            selectedIcon: Icon(Icons.lunch_dining),
            label: "Recetas",
          ),
        ],
      ),
    );
  }
}
