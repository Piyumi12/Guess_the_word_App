import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_word/common/route_generator.dart';
import 'package:guess_the_word/database/db_connect.dart';
import 'package:guess_the_word/helper/note_provider.dart';
import 'package:guess_the_word/screens/chemistry_question.dart';
import 'package:guess_the_word/screens/note_edit_screen.dart';
import 'package:guess_the_word/screens/view_notes.dart';
import 'package:guess_the_word/screens/note_edit_screen.dart';
import 'package:provider/provider.dart';
import 'common/theme_helper.dart';
import 'model/question_model.dart';

void main() async {
  //var db = DBConnect();
 // db.fetchQuestions();

  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
      QuizApp()
  );
}

class QuizApp extends StatelessWidget {



  const QuizApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        title: 'Guess the Word',
        theme: ThemeHelper.getThemeData(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          ViewNotes.routeName:(context)=>ViewNotes(),
          ShortNoteEdit.routeName:(context)=>ShortNoteEdit(),
        },
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
