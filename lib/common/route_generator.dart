import 'package:flutter/material.dart';
import 'package:guess_the_word/screens/home_screen.dart';
import 'package:guess_the_word/screens/quiz_category.dart';
import 'package:guess_the_word/screens/splash_screen.dart';

import '../specialNote/SpecialNote.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case QuizCategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => QuizCategoryScreen());
      case SpecialNote.routeName:
        return MaterialPageRoute(builder: (_) => SpecialNote());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(
            'ERROR: Please try again.',
            style: TextStyle(fontSize: 32),
          ),
        ),
      );
    });
  }
}
