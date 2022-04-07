import 'package:flutter/material.dart';

import '../city/city_answer.dart';
import '../city/city_question.dart';

class CityQuiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  CityQuiz({
    this.questions,
    this.answerQuestion,
    this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CityQuestion(
          questions[questionIndex]['questionText'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return CityAnswer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}
