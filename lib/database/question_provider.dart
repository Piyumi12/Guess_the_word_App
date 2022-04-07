import 'package:guess_the_word/database/const.dart';
import 'package:sqflite/sqflite.dart';

class Question{
  int questionId,categoryId,isImageQuestion;
  String questionText,questionimage,answerA,answerB,answerC,answerD,correctanswer;


  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      columnQuestionId:questionId,
      columnQuestionImage:questionimage,
      columnQuestionText:questionText,
      columnQuestionAnswerA:answerA,
      columnQuestionAnswerB:answerB,
      columnQuestionAnswerC:answerC,
      columnQuestionAnswerD:answerD,
      columnQuestionCorrectAnswer:correctanswer,
      columnQuestionIsImage:isImageQuestion,
      columnQuestionCategoryId:categoryId

    };
  }

  Question();
  Question.fromMap(Map<String,dynamic>map){
    questionId = map[columnQuestionId];
    questionText = map[columnQuestionText];
    questionimage = map[columnQuestionImage];
    isImageQuestion= map[columnQuestionImage];
    answerA=map[columnQuestionAnswerA];
    answerB=map[columnQuestionAnswerB];
    answerC=map[columnQuestionAnswerC];
    answerD=map[columnQuestionAnswerD];
    correctanswer=map[columnQuestionCorrectAnswer];

  }

}

class QuestionProvider{
  Future<Question>getQuestionById(Database db,int id)async{
    var maps = await db.query(tableQuestionName,
        columns: [
          columnQuestionId,
          columnQuestionText,
          columnQuestionImage,
          columnQuestionAnswerA,
          columnQuestionAnswerB,
          columnQuestionAnswerC,
          columnQuestionAnswerD,
          columnQuestionCorrectAnswer,
          columnQuestionIsImage,
          columnQuestionCategoryId
        ],
        where: '$columnQuestionId=?',
        whereArgs: [id]
    );
    if(maps.length>0)return Question.fromMap(maps.first);
    return null;
  }

  Future<List<Question>>getQuestionCategoryById(Database db,int id)async{
    var maps = await db.query(tableQuestionName,
        columns: [
          columnQuestionId,
          columnQuestionText,
          columnQuestionImage,
          columnQuestionAnswerA,
          columnQuestionAnswerB,
          columnQuestionAnswerC,
          columnQuestionAnswerD,
          columnQuestionCorrectAnswer,
          columnQuestionIsImage,
          columnQuestionCategoryId
        ],
        where: '$columnQuestionCategoryId=?',
        whereArgs: [id]
    );
    if(maps.length>0)return maps.map((question) => Question.fromMap(question)).toList();
    return null;
  }

  Future<List<Question>>getQuestions(Database db)async{
    var maps = await db.query(tableQuestionName,
      columns: [
        columnQuestionId,
        columnQuestionText,
        columnQuestionImage,
        columnQuestionAnswerA,
        columnQuestionAnswerB,
        columnQuestionAnswerC,
        columnQuestionAnswerD,
        columnQuestionCorrectAnswer,
        columnQuestionIsImage,
        columnQuestionCategoryId
      ],
    );
    if(maps.length>0)return maps.map((question) => Question.fromMap(question)).toList();
    return null;
  }
}