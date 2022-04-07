import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/helper/database_helper.dart';
import 'package:guess_the_word/model/short_note.dart';

class NoteProvider with ChangeNotifier{

  List _items = [];

  List get items {
    return [..._items];
  }

  Future addOrUpdateNote(int id,String title,String content,String imagePath,EditMode editMode)async{

    final shortNote = ShortNotes(id,title,content,imagePath);
    if(EditMode.ADD == editMode){
      _items.insert(0, shortNote);
    }else{
      _items[_items.indexWhere((shortNote) => shortNote.id==id)]=shortNote;
    }
    notifyListeners();
    DatabaseHelper.insert({
      'id':shortNote.id,
      'title':shortNote.title,
      'content':shortNote.content,
      'imagePath':shortNote.imagePath

    });
  }

  ShortNotes getNote(int id){
    return _items.firstWhere((shortNote) => shortNote.id==id,orElse: ()=>null);
  }

  Future deleteNote(int id){
    _items.removeWhere((element) => element.id==id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }

  Future getNotes()async{
    final notesList = await DatabaseHelper.getNotesFromDB();
    _items = notesList.map((item) => ShortNotes(item['id'],item['title'],item['content'],item['imagePath']),
    ).toList();

    notifyListeners();
  }
}