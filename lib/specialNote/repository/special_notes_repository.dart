import 'package:guess_the_word/database/specialNotesDao.dart';
import 'package:guess_the_word/database/specialNotesModal.dart';

class NotesRepository {
  final notesDao = NotesDao();

  Future getAllNotes({String query}) => notesDao.getNotes(query: query);

  Future getNoteByTitle({String title}) => notesDao.getNoteByTitle(title: title);

  Future insertNotes(Notes notes) => notesDao.createNotes(notes);

  Future updateNotes(Notes notes) => notesDao.updateNotes(notes);

  Future deleteNoteById(int id) => notesDao.deleteNotes(id);

  Future deleteAllNotes() => notesDao.deleteAllNotes();
}