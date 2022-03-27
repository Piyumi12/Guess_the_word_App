import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_word/bloc/form/notes_form_state.dart';
import 'package:guess_the_word/model/notes.dart';
import 'package:guess_the_word/repository/notes_repository.dart';
import 'notes_form_event.dart';

class NotesFormBloc extends Bloc<NotesFormEvent, NotesFormState> {
  final NotesRepository noteRepository;

  NotesFormBloc({@required this.noteRepository}) : super(InitialNotesFormState());

  @override
  Stream<NotesFormState> mapEventToState(NotesFormEvent event) async* {
    yield NotesFormLoading();
    if (event is GetNoteItem) {
      try {
        yield NoteHasData(note: event.note?.title == null ? Notes() : await noteRepository.getNoteByTitle(title : event.note?.title));
      } catch(e) {
        yield NotesFormError(e.toString());
      }
    }
    else if (event is BackEvent) {
      yield InitialNotesFormState();
    } else if (event is CreateNotes) {
      try {
        await noteRepository.insertNotes(event.note);
        yield Success(successMessage : event.note.title + ' created');
      } catch(e) {
        yield NotesFormError(e.toString());
      }
    } else if (event is UpdateNotes) {
      try {
        await noteRepository.updateNotes(event.note);
        yield Success(successMessage: event.note.title + ' updated');
      } catch(e) {
        yield NotesFormError(e.toString());
      }
    }
  }
}