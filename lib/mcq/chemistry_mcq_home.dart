import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/mcq/view_chemistry_quiz.dart';
import 'package:provider/provider.dart';
import '../database/chemistry_quiz_db.dart';
import '../database/chemistry_quiz_item.dart';
import '../screens/quiz_category.dart';

class ChemistryMcqHome extends StatefulWidget {
  static const routeName = '/chemistry-home';

  const ChemistryMcqHome({Key key}) : super(key: key);

  @override
  State<ChemistryMcqHome> createState() => _ChemistryMcqHomeState();
}

class _ChemistryMcqHomeState extends State<ChemistryMcqHome> {
  List<ChemistryQuizItem> active = [
    ChemistryQuizItem(name: "Quiz A", duration: 10, questionNo: 5)
  ];

  List<ChemistryQuizItem> quizzes = [];

  List<Widget> get activeWidgets =>
      quizzes.map((item) => formatQuiz(item)).toList();

  void initState() {
    super.initState();
    DB.init().then((value) => fetchQuiz());
  }

  void dispose() {
    super.dispose();
  }

  void fetchQuiz() async {
    List<Map<String, dynamic>> _results =
        await DB.query(ChemistryQuizItem.table);
    quizzes = _results.map((quiz) => ChemistryQuizItem.fromMap(quiz)).toList();
    setState(() {});
  }

  void _delete(ChemistryQuizItem item) async {
    DB.delete(ChemistryQuizItem.table, item);
    fetchQuiz();
  }

  Widget formatQuiz(ChemistryQuizItem item) {
    return Dismissible(
      key: Key(item.id.toString()),
      child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(colors: [background, Colors.blue[400]]),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ]),
          child: FlatButton(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.questionNo.toString() + " questions",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 16),
                        ),
                        Text(
                          item.duration.toString() + " mins",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 16),
                        ),
                      ],
                    )
                  ])),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewChemistryQuiz(quiz: item)))
                  .then((value) => fetchQuiz()))),
      confirmDismiss: (DismissDirection direction) async {
        _deleteDialog(context, item);
      },
    );
  }

  void _addQuiz(String n, int d, BuildContext c) {
    Navigator.pop(context);
    ChemistryQuizItem q =
        ChemistryQuizItem(name: n, duration: d, questionNo: 0);
    DB.insert(ChemistryQuizItem.table, q);
    fetchQuiz();
  }

  void _createDialog(BuildContext context) {
    String _name = "";
    int _duration = 0;

    var content = TextField(
        decoration: InputDecoration(labelText: "Enter Quiz Name"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          _name = value;
        });
    var duration = TextField(
        decoration: InputDecoration(labelText: "Quiz Duration (in mins)"),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal),
        onChanged: (dur) {
          _duration = int.parse(dur);
        });
    var btn = TextButton(
      child: Text(
        'Save',
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () => _addQuiz(_name, _duration, context),
    );
    var cancelBtn = TextButton(
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
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 16),
                          Text("Create Quiz",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            child: content,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          ),
                          Container(
                            child: duration,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
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

  void _deleteDialog(BuildContext context, ChemistryQuizItem item) {
    TextStyle dialogHeader = GoogleFonts.montserrat(
        color: Color.fromRGBO(59, 57, 60, 1),
        fontSize: 18,
        fontWeight: FontWeight.bold);

    TextStyle labelHeader = GoogleFonts.montserrat(
        color: Color.fromRGBO(59, 57, 60, 1),
        fontSize: 15,
        fontWeight: FontWeight.normal);
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // To make the card compact
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      Text(
                        "Confirm",
                        style: dialogHeader,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Are you sure you wish to delete this item?",
                            textAlign: TextAlign.center,
                            style: labelHeader,
                          )),
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              _delete(item);
                              Navigator.of(context).pop(true);
                            }),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuizCategoryScreen())),
          ),
          title: Text(
            "Chemistry",
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: Visibility(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () {
                _createDialog(context);
              },
              child: Icon(Icons.add, color: Colors.white),
              backgroundColor: background,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        backgroundColor: Colors.white,
        body: ListView(
            children: [SizedBox(height: 10), Column(children: activeWidgets)]));
  }
}
