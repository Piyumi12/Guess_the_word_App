import 'package:flutter/material.dart';
import 'package:guess_the_word/helper/note_provider.dart';
import 'package:guess_the_word/model/short_note.dart';
import 'package:guess_the_word/screens/note_list_screen.dart';
import 'package:guess_the_word/ui/notes_list_screen.dart';
import 'package:provider/provider.dart';
class DeletePopUp extends StatelessWidget {
  //const DeletePopUp({Key key}) : super(key: key);
  final ShortNotes selecetedNote;

  DeletePopUp(this.selecetedNote);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text('Delete?'),
      content: Text("Do you want to delete the short note?"),
      actions: [
        TextButton(
            onPressed: (){
              Provider.of<NoteProvider>(context,listen:false)
                  .deleteNote(selecetedNote.id);
             // Navigator.popUntil(context, ModalRoute.withName(NotesListScreen.routeName));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShortNoteListScreen()));
            },
            child: Text('Yes'),
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('No'))

      ],
    );
  }
}
