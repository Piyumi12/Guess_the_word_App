import 'package:flutter/material.dart';
import 'package:guess_the_word/quizPages/quizPage.dart';
import 'package:guess_the_word/screens/home_screen.dart';
import 'package:guess_the_word/screens/quiz_category.dart';
import 'package:guess_the_word/screens/splash_screen.dart';
import 'package:guess_the_word/specialNote/specialNote.dart';
import 'package:guess_the_word/geography/geography_category.dart';
import 'package:guess_the_word/feedback/Feedback.dart';
import 'package:guess_the_word/geography/country/country_questions.dart';
import 'package:guess_the_word/geography/city/city_questions.dart';
import 'package:guess_the_word/geography/civilization/civilization_questions.dart';
import 'package:guess_the_word/geography/country/country_loader.dart';
import 'package:guess_the_word/geography/city/city_loader.dart';
import 'package:guess_the_word/geography/civilization/civilization_loader.dart';

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
      case QuizPage.routeName:
        return MaterialPageRoute(builder: (_) => QuizPage());


      case GeographyCategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => GeographyCategoryScreen());
      case FeedbackScreen.routeName:
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      case CivilizationQuizLoader.routeName:
        return MaterialPageRoute(builder: (_) => CivilizationQuizLoader());
      case CountryQuizLoader.routeName:
        return MaterialPageRoute(builder: (_) => CivilizationQuizLoader());
      case CityQuizLoader.routeName:
        return MaterialPageRoute(builder: (_) => CivilizationQuizLoader());
      case CountryQuestionsScreen.routeName:
        return MaterialPageRoute(builder: (_) => CountryQuestionsScreen());
      case CityQuestionsScreen.routeName:
        return MaterialPageRoute(builder: (_) => CityQuestionsScreen());
      case CivilizationQuestionsScreen.routeName:
        return MaterialPageRoute(builder: (_) => CivilizationQuestionsScreen());


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
