import 'dart:core';

import 'package:flutter/material.dart';
import 'package:guess_the_word/common/theme_helper.dart';
import 'package:guess_the_word/quizPages/quizPage.dart';

import '../specialNote/specialNote.dart';
import '../feedback/Feedback.dart';
import '../geography/geography_category.dart';
import '../widgets/disco_button.dart';

class QuizCategoryScreen extends StatefulWidget {
  static const routeName = '/quizCategory';
  const QuizCategoryScreen({Key key}) : super(key: key);

  @override
  _QuizCategoryScreenState createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: const Image(
                      image: AssetImage("assets/icons/back.png"),
                      width: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Quiz Categories",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              ...homeScreenButtons(context),
            ],
          ),

        ),
      ),
    ),
  );
}

List<Widget> homeScreenButtons(BuildContext context) {
  return [
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, GeographyCategoryScreen.routeName);
      },
      child: Text(
        "Geography",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, QuizCategoryScreen.routeName);
      },
      child: Text(
        "Physics",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, QuizCategoryScreen.routeName);
      },
      child: Text(
        "Chemistry",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, QuizPage.routeName);
      },
      child: Text(
        "Biology",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, SpecialNote.routeName);
      },
      child: Text(
        "Special Note",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
    DiscoButton(
      onPressed: () {
        Navigator.pushNamed(context, FeedbackScreen.routeName);
      },
      child: Text(
        "Feedback",
        style: TextStyle(
          fontSize: 30,
          color: ThemeHelper.primaryColor,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(top: 20.0),
    ),
  ];
}
}
