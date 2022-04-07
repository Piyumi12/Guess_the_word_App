import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/database/chemistry_quiz_item.dart';
import 'package:guess_the_word/mcq/chemistry_mcq_home.dart';
import 'package:guess_the_word/screens/quiz_category.dart';

import '../database/chemistry_quiz_db.dart';
import '../database/question_item.dart';

class ViewQuestions extends StatefulWidget{
  final ChemistryQuizItem quiz;

  ViewQuestions({this.quiz});

  @override
  State<StatefulWidget> createState() => _ViewQuestionsState(quiz: this.quiz);
}

class _ViewQuestionsState extends State<ViewQuestions>{

  final ChemistryQuizItem quiz;

  int index = 0;
  int score = 0;

  _ViewQuestionsState({this.quiz});

  List<QuestionItem> questions  = [];
  List<Widget> get questionsList => questions.map((item) => formatQuestions(item)).toList();

  void initState(){
    super.initState();
    fetchQuestions();
  }

  void dispose() {
    super.dispose();
  }

  void fetchQuestions() async{
    List<Map<String, dynamic>> _results = await DB.queryQuestions(QuestionItem.table, quiz);
    questions = _results.map((quiz) => QuestionItem.fromMap(quiz)).toList();
    setState(() {});
  }

  Widget formatQuestions(QuestionItem question){
    return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(question.question,
              style:
              GoogleFonts.montserrat(color: Colors.black, fontSize: 20),),
            SizedBox(height: 50),
            Column(children:answerButtons(question)),
            SizedBox(height: 150),
          ],
        )
    );
  }

  Widget answerButton(String s, bool isCorrect){
    void action(){
      if(isCorrect){
        setState(() {
          index += 1;
          score += 1;
        });
      }
      else{
        setState(() {
          index += 1;
        });
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [background,
                Colors.blue[400]]),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5)
            )
          ]
      ),
      child:
      FlatButton(child:
      Container(
          padding: EdgeInsets.all(20),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s, style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16
                    ),
                    ),
                  ],
                ),
              ]
          )
      ),
          onPressed: () => action()),
    );
  }

  void correct(){
    setState(() {
      index += 1;
      score += 1;
    });
  }

  void incorrect(){
    setState(() {
      index += 1;
    });
  }

  List<Widget> answerButtons(QuestionItem q){
    List<Widget> buttons = [];
    buttons.add(answerButton(q.correctAnswer, true));
    buttons.add(answerButton(q.wrongAnswerA, false));
    buttons.add(answerButton(q.wrongAnswerB, false));
    buttons.add(answerButton(q.wrongAnswerC, false));
    buttons.shuffle();
    return buttons;
  }

  Widget body(){
    if(questionsList.length == index){
      return Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "You got a score of  " + score.toString() + " / " + index.toString() + " !",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
              ),
              SizedBox(height: 10),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChemistryMcqHome()),
                );
              },
                  child: Text(
                      "Start Again",
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),

              )
            ],
          )
      );
    } else{
      return questionsList[index];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: background,
          title: Text(
            "Chemistry",
            style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16),
          ),
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizCategoryScreen()));
            },
          ),
        ),
        body: body()
    );
  }
}