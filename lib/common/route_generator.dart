import 'package:flutter/material.dart';
import 'package:guess_the_word/mcq/chemistry_mcq_home.dart';
import 'package:guess_the_word/screens/chemistry_home.dart';
import 'package:guess_the_word/screens/home_screen.dart';
import 'package:guess_the_word/screens/note_edit_screen.dart';
import 'package:guess_the_word/screens/quiz_category.dart';
import 'package:guess_the_word/screens/splash_screen.dart';
import 'package:guess_the_word/screens/chemistry_question.dart';
import 'package:guess_the_word/screens/view_notes.dart';
import '../specialNote/SpecialNote.dart';
import 'package:guess_the_word/screens/note_list_screen.dart';

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
      case Chemistry.routeName:
        return MaterialPageRoute(builder: (_) => Chemistry());
      // case ChemistryHomePage.routeName:
      //   return MaterialPageRoute(builder: (_) => ChemistryHomePage());
      case ChemistryMcqHome.routeName:
        return MaterialPageRoute(builder: (_) => ChemistryMcqHome());
      case ShortNoteListScreen.routeName:
        return MaterialPageRoute(builder: (_) => ShortNoteListScreen());
      case ViewNotes.routeName:
        return MaterialPageRoute(builder: (_) => ViewNotes());
      case ShortNoteEdit.routeName:
        return MaterialPageRoute(builder: (_) => ShortNoteEdit());
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
