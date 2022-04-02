import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/theme.dart';
import 'homepage.dart';

class QuizPage extends StatelessWidget {
  static const routeName = '/quizPage';
  const QuizPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: notifier.isDarkTheme ? dark : light,
              home: HomePage(),
            );
          },
        )
      )
    );
  }
}
