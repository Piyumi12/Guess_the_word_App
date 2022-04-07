import 'package:guess_the_word/quizPages/phyCreateQuiz.dart';
import '../widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/screens/quiz_category.dart';
import 'package:provider/provider.dart';
import '../widgets/theme.dart';
import '../widgets/navDrawer.dart';
import 'package:guess_the_word/database/physicsDb.dart';
import 'package:guess_the_word/database/quizItem.dart';
import 'package:guess_the_word/quizPages/view_physics_quiz.dart';



class QuizPhysicsPage extends StatefulWidget {

  const QuizPhysicsPage({Key key}) : super(key: key);



  @override
  _QuizPhysicsPageState createState() => _QuizPhysicsPageState();
}

class _QuizPhysicsPageState extends State<QuizPhysicsPage> {

  List<QuizItem> active  = [
    QuizItem(
        name: "Quiz A",
        duration: 10,
        questionNo: 5
    )
  ];

  List<QuizItem> quizzes = [];
  List<Widget> get activeWidgets => quizzes.map((item) => formatQuiz(item)).toList();

  void initState(){
    super.initState();
    DB.init().then((value) => fetchQuiz());
  }

  void dispose() {
    super.dispose();
  }


  void fetchQuiz() async{
    List<Map<String, dynamic>> _results = await DB.query(QuizItem.table);
    quizzes = _results.map((quiz) => QuizItem.fromMap(quiz)).toList();
    setState(() {});
  }

  void _delete(QuizItem item) async {
    DB.delete(QuizItem.table, item);
    fetchQuiz();
  }

  Widget formatQuiz(QuizItem item){
    return Dismissible(

      key: Key(item.id.toString()),
      child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(colors: [Colors.blue[700], Colors.blue[400]]),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5)
                )
              ]
          ),
          child: FlatButton(child: Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name, style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.questionNo.toString() + " questions" , style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            fontSize: 16
                        ),
                        ),
                        Text(item.duration.toString() + " mins", style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            fontSize: 16
                        ),
                        ),
                      ],
                    )
                  ]
              )
          ), onPressed: () =>
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ViewPhysicsQuiz(quiz: item)
                  )
              ).then((value) => fetchQuiz())
          )
      ),
      confirmDismiss: (DismissDirection direction) async {
        _deleteDialog(context, item);
      },
    );
  }

  void _addQuiz(String n, int d, BuildContext c){
    Navigator.pop(context);
    QuizItem q = QuizItem(
        name: n,
        duration: d,
        questionNo: 0
    );
    DB.insert(QuizItem.table, q);
    fetchQuiz();
  }

  void _createDialog(BuildContext context){
    String _name = "";
    int _duration = 0;

    var content = TextField(
        decoration: InputDecoration(
            labelText: "Quiz Name"
        ),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal
        ),
        onChanged: (value) {
          _name = value;
        }
    );
    var duration = TextField(
        decoration: InputDecoration(
            labelText: "Duration (in mins)"
        ),
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(105, 105, 108, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal
        ),
        onChanged: (dur) {
          _duration = int.parse(dur);
        }
    );
    var btn = FlatButton(
      child: Text(
        'Save',
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () => _addQuiz(_name, _duration, context),
    );
    var cancelBtn = FlatButton(
      child: Text(
        'Cancel',
        style: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () => Navigator.of(context).pop(false),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
          ),
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
                            offset: Offset(0, 10)
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      Text("Add Quiz", style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(59, 57, 60, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )),
                      Container(child: content, padding: EdgeInsets.fromLTRB(20, 10, 20, 10),),
                      Container(child: duration, padding: EdgeInsets.fromLTRB(20, 10, 20, 20),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [btn, cancelBtn],
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

  void _deleteDialog(BuildContext context, QuizItem item){
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            ),
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
                    mainAxisSize: MainAxisSize.min, // To make the card compact
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
                        FlatButton(
                            child: Text('Delete'),
                            onPressed: () {
                              _delete(item);
                              Navigator.of(context).pop(true);
                            }),
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),)
                      ]),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(

          backgroundColor: Colors.deepPurple,
          title: Text("Physics",
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
              backgroundColor: Colors.deepPurple,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
            children: [
              Column(children: activeWidgets)
            ]
        )

    );
  }

}