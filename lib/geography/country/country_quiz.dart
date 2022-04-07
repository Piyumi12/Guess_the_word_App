import 'package:flutter/material.dart';

import '../country/country_answer.dart';
import '../country/country_question.dart';

class CountryQuiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  CountryQuiz({
     this.questions,
    this.answerQuestion,
     this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountryQuestion(
          questions[questionIndex]['questionText'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return CountryAnswer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}
