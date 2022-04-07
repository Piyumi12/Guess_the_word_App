import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbPhysicsNote{

  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "physic.db"),
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                "CREATE TABLE physic(id,INTEGER PRIMARYKEY, topic TEXT, description TEXT)");
          }
      );
    }
  }
  Future<int> insertNote(Note note)async {
    await openDb();
    return await _database.insert('physic',note.toMap());

  }
  Future<List<Note>>getNoteList() async {
    await openDb();
    final List<Map<String,dynamic>> maps = await _database.query('physic');
    return List.generate(maps.length,(i){
      return Note(
        id: maps[i]['id'],
        topic: maps[i]['topic'],
        description: maps[i]['description']
      );
    });
  }
  Future<int> updateNote(Note note)async {
    await openDb();
    return await _database.update('physic', note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id)async {
    await openDb();
    await _database.delete('physic',where: "id = ?", whereArgs: [id]
    );
}
}
class Note{
  int id;
  String topic;
  String description;

  Note({@required this.topic,@required this.description,id});
  Map<String,dynamic>toMap(){

    return {'topic':topic,'description':description};
  }
}