import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:guess_the_word/specialNote/form/special_notes_form_bloc.dart';
import 'package:guess_the_word/specialNote/list/special_notes_list_bloc.dart';
import 'package:guess_the_word/specialNote/list/special_notes_list_event.dart';
import 'package:guess_the_word/specialNote/repository/special_notes_repository.dart';
import 'package:guess_the_word/specialNote/ui/notes_list_screen.dart';

class SpecialNote extends StatelessWidget {
  static const routeName = '/specialNote';
  const SpecialNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<NotesListBloc>(
              create: (context) {
                return NotesListBloc(noteRepository: NotesRepository())..add(GetNotes());
              },
            ),
            BlocProvider<NotesFormBloc>(
              create: (context) {
                return NotesFormBloc(noteRepository: NotesRepository());
              },
            )
          ],
          child: NotesListScreen(),
        )
    );
  }
}
