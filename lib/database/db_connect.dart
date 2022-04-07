import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:guess_the_word/model/question_model.dart';
// import 'dart:convert';
//
// class DBConnect{
//   final url = Uri.parse('https://guesstheword-b1883-default-rtdb.firebaseio.com/chemistry.json');
//   Future<void>addQuestion(Question question)async{
//     http.post(url,body:json.encode({
//       'title':question.title,
//       'options':question.options
//     }));
//   }
//
//   Future<void>fetchQuestions()async{
//     http.get(url).then((response) {
//       var data = json.decode(response.body) as Map<String,dynamic>;
//       List<Question> newQuestion = [];
//       data.forEach((key, value) {
//         var newQuestion = Question(
//           id:key,
//           title: value['title'],
//           options: Map.castFrom(value['options']),
//         );
//         //newQuestion.add(newQuestion);
//       });
//       print(data);
//     });
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'const.dart';

Future<Database>copyDB()async{
  var dbPath = await getDatabasesPath();
  var path = join(dbPath,db_name);

  var exists = await databaseExists(path);
  if(!exists){
    try{
      await Directory(dirname(path)).create(recursive:true);
    }catch(_){

    }
    ByteData data = await rootBundle.load(join('assets/db',db_name));
    List <int>bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
    await File(path).writeAsBytes(bytes,flush:true);
  }else{
    print('DB already exists');
  }
  return await openDatabase(path,readOnly: true);
}