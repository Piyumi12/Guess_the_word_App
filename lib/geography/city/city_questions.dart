import 'package:flutter/material.dart';
import 'city_result.dart';
import 'city_quiz.dart';

class CityQuestionsScreen extends StatefulWidget {
  static const routeName = '/countryQuestions';
  const CityQuestionsScreen({Key key}) : super(key: key);

  @override
  _CityQuestionsScreenState createState() => _CityQuestionsScreenState();
}


class _CityQuestionsScreenState extends State<CityQuestionsScreen> {
  final _questions = const [
    {
      'questionText': 'Q1. Name the city which is a seat of UNO International Court of Justice',
      'answers': [
        {'text': 'Hamburg', 'score': -2},
        {'text': 'Greenwich', 'score': -2},
        {'text': 'Hague', 'score': 10},
        {'text': 'Geneva', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2.Which city of the United States is famous for film making?',
      'answers': [
        {'text': 'New York', 'score': -2},
        {'text': 'Chicago', 'score': -2},
        {'text': 'Kansas', 'score': -2},
        {'text': 'Hollywood', 'score': 10},
      ],
    },
    {
      'questionText': ' Q3. Name the city where Jesus Christ was crucified and is called the Holy City.',
      'answers': [
        {'text': 'Jerico', 'score': -2},
        {'text': 'Jerusalem', 'score': 10},
        {'text': 'Damascus', 'score': -2},
        {'text': 'Baghdad', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Which city has the temple of Tooth (Buddha’s Tooth)?',
      'answers': [
        {'text': 'Kandy', 'score': 10},
        {'text': 'Sao Pola', 'score': -2},
        {'text': 'Kalgoorlie', 'score': -2},
        {'text': 'Lop Nor', 'score': -2},
      ],
    },
    {
      'questionText':
      'Q5. Which is the third most populous city of the world and a capital of a country?',
      'answers': [
        {'text': 'Delhi', 'score': -2,},
        {'text': 'London', 'score': 10},
        {'text': 'Ankara', 'score': -2},
        {'text': 'Dhakka', 'score': -2},
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
              ? CityQuiz(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) //Quiz
              : CityResult(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold

    ); //MaterialApp
  }
}
