import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/common/theme_helper.dart';
import 'package:guess_the_word/widgets/disco_button.dart';

import 'quiz_category.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Container(
          padding: const EdgeInsets.only(top: 60.0),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Guess the Word",
                    style: GoogleFonts.fredokaOne(
                        color: Colors.indigo,
                        fontSize: 62,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      height: 30
                  ),
                  Text(
                    "Dashboard",
                    style: GoogleFonts.aBeeZee(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                      height: 30
                  ),
                  ...homeScreenButtons(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> homeScreenButtons(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.only(top: 20.0),
      ),
      DiscoButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizCategoryScreen.routeName);
        },
        child: Text(
          "Quiz Category",
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
        onPressed: ()=> SystemNavigator.pop(),
        child: Text(
          "Quit",
          style: TextStyle(
              fontSize: 30,
              color: ThemeHelper.primaryColor
          ),
        ),
      ),
    ];
  }
}
