import 'package:flutter/material.dart';

class CountryQuestion extends StatelessWidget {
  final String questionText;

  CountryQuestion(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.justify,
      ), //Text
    ); //Container
  }
}
