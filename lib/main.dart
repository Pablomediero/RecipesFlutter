import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receptom/di/app_modules.dart';
import 'package:receptom/presentation/navigation/navigation_routes.dart';
import 'package:receptom/presentation/provider/control_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppModules().setup();
  inject.allReady().then((_) {
    runApp(ChangeNotifierProvider(
      create: (context) => MiProvider(),
      child: const MainApp(),
    ));
  }).catchError((error) {
    print('Error during dependency injection: $error');
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
