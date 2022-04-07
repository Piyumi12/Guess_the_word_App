import 'package:flutter/material.dart';
import 'civilization_result.dart';
import 'civilization_quiz.dart';

class CivilizationQuestionsScreen extends StatefulWidget {
  static const routeName = '/civilizationQuestions';
  const CivilizationQuestionsScreen({Key key}) : super(key: key);

  @override
  _CivilizationQuestionsScreenState createState() => _CivilizationQuestionsScreenState();
}


class _CivilizationQuestionsScreenState extends State<CivilizationQuestionsScreen> {
  final _questions = const [
    {
      'questionText': 'Q1. During which ancient civilization pygmies and dwarfs were seen as people with celestial gifts?',
      'answers': [
        {'text': 'Roman', 'score': -2},
        {'text': 'Mesopotamia', 'score': -2},
        {'text': 'Egypt', 'score': 10},
        {'text': 'Jiahu', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2.Which ancient civilization regarded childbirth as a form of battle. Women who died during childbirth were believed to become the companions of the Sun and rise to the highest heavens?',
      'answers': [
        {'text': 'Indus', 'score': -2},
        {'text': 'Mesopotamia', 'score': -2},
        {'text': 'Egypt', 'score': -2},
        {'text': 'Aztec', 'score': 10},
      ],
    },
    {
      'questionText': ' Q3. Which cities were the first to ever have block and grid plan for their streets?',
      'answers': [
        {'text': 'Roman', 'score': -2},
        {'text': 'Harappa and Mohenjo-daro', 'score': 10},
        {'text': 'Mesopotamia', 'score': -2},
        {'text': 'Norte Chico', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Which of these was not an ancient Phoenician city?',
      'answers': [
        {'text': 'Madrid', 'score': 10},
        {'text': 'Tyre', 'score': -2},
        {'text': 'Sidon', 'score': -2},
        {'text': 'Berot', 'score': -2},
      ],
    },
    {
      'questionText':
      'Q5.  Who colonized Tunisia in ancient times?',
      'answers': [
        {'text': 'Philistines', 'score': -2,},
        {'text': 'Phoenicians', 'score': 10},
        {'text': 'Palmyrans', 'score': -2},
        {'text': 'Pyrgamese', 'score': -2},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Country Quiz'),
          backgroundColor: Colors.deepPurple,

        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? CivilizationQuiz(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) //Quiz
              : CivilizationResult(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold

    ); //MaterialApp
  }
}
