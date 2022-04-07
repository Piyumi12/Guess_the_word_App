import 'package:flutter/material.dart';

class CivilizationAnswer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  CivilizationAnswer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.black12,
        textColor: Colors.black,
        child: Text(answerText),
        onPressed: selectHandler,
      ), //RaisedButton
    ); //Container
  }
}
