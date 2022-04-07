import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/model/question_model.dart';
import 'package:guess_the_word/widgets/question_widget.dart';
import 'package:guess_the_word/widgets/next_button.dart';
import 'package:guess_the_word/widgets/options_card.dart';
import 'package:guess_the_word/widgets/result_box.dart';
import 'package:guess_the_word/database/db_connect.dart';

class Chemistry extends StatefulWidget {
  static const routeName = '/chemistry';
  const Chemistry({Key key}) : super(key: key);

  @override
  State<Chemistry> createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {

  //var db = DBConnect();
  ///Future _questions;

   final List<Question> _questions = [
     Question(
      id: '10',
       title: 'What is atom?',
      options: {'5':false,'3':true,'4':false},
    ),
   Question(
      id: '10',
      title: 'What is atom?',
     options: {'5':false,'3':true,'4':false},
    ),
  ];

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion(){
    if(index==_questions.length-1){
     showDialog(
         context: context,
         barrierDismissible: false,
         builder: (ctx)=>ResultBox(
           result: score,
           questionLength: _questions.length,
           onPressed: startOver,
         ));
    }else{
      if(isPressed){
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:Text("Please select any option"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(vertical: 20.0),
            ),
        );
      }
    }
  }

  void checkAnswersAndUpdate(bool value){
    if(isAlreadySelected){
      return;
    }else{
      if(value == true){
        score++;
    }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver(){
    setState(() {
      index =0;
      score =0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Chemistry"),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.all(18.0),
            child: Text("Score : $score",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestions: _questions.length,
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for(int i=0;i<_questions[index].options.length;i++)
              GestureDetector(
                onTap: ()=>checkAnswersAndUpdate(_questions[index].options.values.toList()[i]),
                child:OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed ? _questions[index].options.values.toList()[i] == true ? correct:incorrect:neutral,

                ),
              ),

          ],
        ),
      ),
      floatingActionButton:Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
