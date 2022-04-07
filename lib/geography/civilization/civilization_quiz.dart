import 'package:flutter/material.dart';

import '../civilization/civilization_answer.dart';
import '../civilization/civilization_question.dart';

class CivilizationQuiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  CivilizationQuiz({
    this.questions,
    this.answerQuestion,
    this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CivilizationQuestion(
          questions[questionIndex]['questionText'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return CivilizationAnswer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}
