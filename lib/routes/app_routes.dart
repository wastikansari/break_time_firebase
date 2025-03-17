import 'package:break_time/utiles/constants.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static String get initialRoute => Constants.loginRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Constants.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Constants.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
