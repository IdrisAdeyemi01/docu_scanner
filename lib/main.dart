import 'package:docu_scanner/src/core/router/routes.dart';

import 'package:docu_scanner/src/services/navigation_service/navigation_service.dart';
import 'package:docu_scanner/src/services/snackbar_service/snackbar_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.homePage,
      navigatorKey: NavigationService().navigatorKey,
      scaffoldMessengerKey: SnackbarService().scaffoldMessengerKey,
    );
  }
}
