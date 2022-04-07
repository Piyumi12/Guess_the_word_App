import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static Future database()async{
    final databasePath = await getDatabasesPath();
    return openDatabase(join(databasePath,'short_notes.db'),
      onCreate: (database,version){
      return database.execute(
          'CREATE TABLE shortNotes(id INTEGER PRIMARY KEY,title TEXT,content TEXT,imagePath TEXT)');
      },version: 1);
  }

  static Future insert(Map<String,Object>data)async{
    final database = await DatabaseHelper.database();

    database.insert("shortNotes",data,
      conflictAlgorithm:ConflictAlgorithm.replace
    );

  }

  static Future<List<Map<String,dynamic>>>getNotesFromDB()async{
    final database = await DatabaseHelper.database();
    return database.query('shortNotes',orderBy:'id DESC');
  }

  static Future delete(int id)async{
    final database = await DatabaseHelper.database();
    return database.delete('shortNotes',where:'id = ?',whereArgs:[id]);
  }
}