import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/helper/note_provider.dart';
import 'package:guess_the_word/model/short_note.dart';
import 'package:guess_the_word/screens/note_edit_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../widgets/delete_popup.dart';

class ViewNotes extends StatefulWidget {
  static const routeName = '/view-note';

  const ViewNotes({Key key}) : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  ShortNotes selectedNote;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<NoteProvider>(context);

    if (provider.getNote(id) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _showDialog(),
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedNote?.title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28.0,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text('${selectedNote?.date}')
              ],
            ),
            if (selectedNote.imagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(File(selectedNote.imagePath)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedNote.content,
                style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 20.0,
                    height: 1.5,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: background,
        onPressed: () {
          Navigator.pushNamed(context, ShortNoteEdit.routeName,
              arguments: selectedNote.id);
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote);
        });
  }
}
