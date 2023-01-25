import 'package:flutter/material.dart';
import 'package:walaaprovider/features/navigation_bottom/screens/navigation_bottom.dart';

import '../../features/auth/login/presentation/screens/login.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';


class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginPage';
  static const NavigationBottomRoute = '/NavigationBottom';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
        case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        );
      case Routes.NavigationBottomRoute:
        return MaterialPageRoute(
          builder: (context) =>  NavigationBottom(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
