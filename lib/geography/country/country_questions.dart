import 'package:flutter/material.dart';
import 'country_result.dart';
import 'country_quiz.dart';

class CountryQuestionsScreen extends StatefulWidget {
  static const routeName = '/countryQuestions';
  const CountryQuestionsScreen({Key key}) : super(key: key);

  @override
  _CountryQuestionsScreenState createState() => _CountryQuestionsScreenState();
}


class _CountryQuestionsScreenState extends State<CountryQuestionsScreen> {
  final _questions = const [
    {
      'questionText': 'Q1. What country has the longest coastline in the world?',
      'answers': [
        {'text': 'Iceland', 'score': -2},
        {'text': 'Russia', 'score': -2},
        {'text': 'Canada', 'score': 10},
        {'text': 'Argentina', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2.To what country to the Canary Islands belong?',
      'answers': [
        {'text': 'Singapore', 'score': -2},
        {'text': 'United Kingdom', 'score': -2},
        {'text': 'United States of America', 'score': -2},
        {
          'text':
          'Spain',
          'score': 10
        },
      ],
    },
    {
      'questionText': ' Q3. What is the name of the largest country in the world?',
      'answers': [
        {'text': 'Brazil', 'score': -2},
        {'text': 'Russia', 'score': 10},
        {'text': 'United States of America', 'score': -2},
        {'text': 'Canada', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. What country are the Great Pyramids of Giza located in?',
      'answers': [
        {'text': 'Egypt', 'score': 10},
        {'text': 'Morocco', 'score': -2},
        {'text': 'Nigeria', 'score': -2},
        {'text': 'Algeria', 'score': -2},
      ],
    },
    {
      'questionText':
      'Q5. What country has the most natural lakes?',
      'answers': [
        {
          'text': 'Sri Lanka',
          'score': -2,
        },
        {'text': 'Canada', 'score': 10},
        {'text': 'Brazil', 'score': -2},
        {'text': 'South Africa', 'score': -2},
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
              ? CountryQuiz(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) //Quiz
              : CountryResult(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold

    ); //MaterialApp
  }
}
