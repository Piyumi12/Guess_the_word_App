import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/helper/note_provider.dart';
import 'package:guess_the_word/model/short_note.dart';
import 'package:guess_the_word/screens/view_notes.dart';
import 'package:guess_the_word/widgets/delete_popup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:guess_the_word/screens/note_list_screen.dart';

class ShortNoteEdit extends StatefulWidget {
  static const routeName = '/edit-note';
  const ShortNoteEdit({Key key}) : super(key: key);

  @override
  State<ShortNoteEdit> createState() => _ShortNoteEditState();
}

class _ShortNoteEditState extends State<ShortNoteEdit> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  bool firstTime = true;
  ShortNotes selectedNote;
  int id;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(firstTime){
      id = ModalRoute.of(this.context).settings.arguments;

      if(id!=null){
        selectedNote = Provider.of<NoteProvider>(
            this.context,
          listen: false,
        ).getNote(id);
        titleController.text = selectedNote?.title;
        contentController.text = selectedNote?.content;

        if(selectedNote?.imagePath!=null){
          _image = File(selectedNote.imagePath);
        }
      }
    }
    firstTime = false;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      appBar: AppBar(elevation: 0.7,
        backgroundColor: background,
        leading: IconButton(onPressed: ()=>Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: (){
               getImage(ImageSource.camera);

          }, icon:Icon(Icons.photo_camera),
            color: Colors.white,
          ),
          IconButton(
            onPressed: (){
             getImage(ImageSource.camera);

            }, icon:Icon(Icons.insert_photo),
            color: Colors.white,
          ),
          IconButton(
            onPressed: (){
              if(id!=null){
                _showDialog();
              }else{
               // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShortNoteListScreen()));
              }
            }, icon:Icon(Icons.delete),
            color: Colors.white,
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(
              left: 10.0,
              right: 5.0,
              top: 10.0,
              bottom: 5.0
            ),
              child: TextField(
                controller: titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter note title',
                  border: InputBorder.none
                ),
              ),
            ),
            if(_image!=null)
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: FileImage(_image),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    Align(alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                _image = null;
                              });
                            },
                            child: Icon(Icons.delete,size: 16.0,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Padding(padding: const EdgeInsets.only(
              left: 10.0,
              right: 5.0,
              top: 10.0,
              bottom:5.0
            ),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 20.0,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Something",
                  border: InputBorder.none
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: background,
        onPressed: (){
          if(titleController.text.isEmpty)
            titleController.text = 'Untitled note';
          saveNote();
        },
        child: Icon(
            Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }

  getImage(ImageSource imageSource)async {
    XFile imageFile = await picker.pickImage(source: imageSource);
    if(imageFile==null)return;

    File tempFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    tempFile = await tempFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = tempFile;
    });

  }

  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();
    String imagePath = _image != null ? _image.path:null;

    if(id!=null){
      Provider.of<NoteProvider>(this.context,listen: false)
          .addOrUpdateNote(id,title,content,imagePath,EditMode.UPDATE);
      Navigator.of(this.context).pop();
    }else{
      int id = DateTime.now().microsecondsSinceEpoch;
      Provider.of<NoteProvider>(this.context,listen: false)
          .addOrUpdateNote(id,title,content,imagePath,EditMode.ADD);
      //Navigator.of(this.context).pushReplacement(ViewNotes.routeName,arguments:id);
      //Navigator.pushNamed(context, ViewNotes.routeName);
      Navigator.of(this.context).pushReplacementNamed(ViewNotes.routeName,arguments:id);
    }

  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context){
          return DeletePopUp(selectedNote);
        }
    );
  }
}

