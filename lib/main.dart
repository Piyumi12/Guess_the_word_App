import 'package:flutter/material.dart';
import 'package:guess_the_word/common/route_generator.dart';

import 'common/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      QuizApp()
  );
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the Word',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
