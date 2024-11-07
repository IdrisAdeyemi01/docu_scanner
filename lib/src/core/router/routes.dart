import 'package:docu_scanner/src/features/home/view/home_page.dart';
import 'package:docu_scanner/src/features/home/view/image_display.dart';
import 'package:flutter/material.dart';

class Routes {
  static const homePage = '/homeView';
  static const imageDisplay = '/imageDisplay';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case imageDisplay:
        final imageString = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ImageDisplay(imageString: imageString));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
