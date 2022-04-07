import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/mcq/display_question.dart';

import '../database/chemistry_quiz_db.dart';
import '../database/chemistry_quiz_item.dart';
import '../database/question_item.dart';

class ViewChemistryQuiz extends StatefulWidget {
  //const ViewChemistryQuiz({Key key}) : super(key: key);
  final ChemistryQuizItem quiz;

  ViewChemistryQuiz({this.quiz});

  @override
  State<ViewChemistryQuiz> createState() => _ViewChemistryQuizState(quiz: this.quiz);
}

class _ViewChemistryQuizState extends State<ViewChemistryQuiz> {
  final ChemistryQuizItem quiz;

  _ViewChemistryQuizState({this.quiz});

  List<QuestionItem> questions = [];
  List<Widget> get activeWidgets =>
      questions.map((item) => formatQuestions(item)).toList();

  void initState() {
    super.initState();
    fetchQuestions();
  }

  void dispose() {
    super.dispose();
  }

  void _addQuestion(List info, BuildContext c) {
    print(info);
    Navigator.pop(context);
    QuestionItem q = QuestionItem(
        questionId: quiz.id,
        question: info[0],
        correctAnswer: info[1],
        wrongAnswerA: info[2],
        wrongAnswerB: info[3],
        wrongAnswerC: info[4]);
    DB.insert(QuestionItem.table, q);
    quiz.questionNo += 1;
    DB.update(ChemistryQuizItem.table, quiz);
    fetchQuestions();
  }

  void _createDialog(BuildContext context) {
    List _questionInfo = ["", "", "", "", ""];
    var question = TextField(
        decoration: InputDecoration(labelText: "Question"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _questionInfo[0] = value;
        });
    var cAnswer = TextField(
        decoration: InputDecoration(labelText: "Correct Answer"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _questionInfo[1] = value;
        });
    var wAnswer1 = TextField(
        decoration: InputDecoration(labelText: "Wrong Answer 1"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _questionInfo[2] = value;
        });
    var wAnswer2 = TextField(
        decoration: InputDecoration(labelText: "Wrong Answer 2"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _questionInfo[3] = value;
        });
    var wAnswer3 = TextField(
        decoration: InputDecoration(labelText: "Wrong Answer 3"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _questionInfo[4] = value;
        });
    var btn = FlatButton(
      child: Text(
        'Save',
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () => _addQuestion(_questionInfo, context),
    );
    var cancelBtn = FlatButton(
      child: Text(
        'Cancel',
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () => Navigator.of(context).pop(false),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text("Add Quiz",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(59, 57, 60, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            question,
                            cAnswer,
                            wAnswer1,
                            wAnswer2,
                            wAnswer3
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [btn, cancelBtn],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  void fetchQuestions() async {
    List<Map<String, dynamic>> _results =
    await DB.queryQuestions(QuestionItem.table, quiz);
    questions = _results.map((quiz) => QuestionItem.fromMap(quiz)).toList();
    setState(() {});
  }

  Widget formatQuestions(QuestionItem item) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: EdgeInsets.only(right: 20.0),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            gradient:
            LinearGradient(
                colors: [background,
                  Colors.blue[400]]),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Expanded(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.question,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                      style:
                      GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15
                      ),
                    ),
                  ],
                ),
              ])),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: background,
          title: Text(
            "Chemistry",
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _createDialog(context))
          ],
        ),
        floatingActionButton: Visibility(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewQuestions(quiz: quiz))),
              child: Icon(
                  Icons.play_arrow,
                  color: Colors.white),
              backgroundColor: background,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        body: ListView(
          children:[
            SizedBox(height: 10),
           Column(children: activeWidgets)
          ],
        ),
            );
  }
}
