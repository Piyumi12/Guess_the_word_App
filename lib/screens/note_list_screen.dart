import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';
import 'package:guess_the_word/helper/note_provider.dart';
import 'package:guess_the_word/screens/note_edit_screen.dart';
import 'package:guess_the_word/widgets/list_item.dart';
import 'package:provider/provider.dart';

class ShortNoteListScreen extends StatelessWidget {
  static const routeName = '/shortNotes';
  const ShortNoteListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context,listen: false).getNotes(),
        builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else{
          if(snapshot.connectionState==ConnectionState.done){
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context,noteprovider,child)=>
                noteprovider.items.length <=0 ? child:ListView.builder(
                  itemCount: noteprovider.items.length + 1,
                    itemBuilder: (context,index){
                    if(index==0){
                      return header();
                    }else{
                      final i = index - 1;
                      final item = noteprovider.items[i];
                      return ListItem(item.id,item.title,item.content,item.imagePath,item.date);
                    }
                    }),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: background,
                onPressed: (){
                goToNoteEditScreen(context);
              },
                child: Icon(
                    Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          }
        }
        return Container();
    }
    );
  }

  Widget header(){
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(75.0),
            )
        ),
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Notes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget noNotesUI(BuildContext context){
    return ListView(
      children: [
        header(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                "assets/images/child.jpg",
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
              ),
            ),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
              children: [
                TextSpan(text: 'There is no note available\n Tap on "'),
                TextSpan(text: ' + ',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap=(){
                  goToNoteEditScreen(context);
                  }
                ),
                TextSpan(text: '" to add new note'),
              ]
            ),
            )
          ],
        )
      ],
    );
 }

 void goToNoteEditScreen(BuildContext context){
    Navigator.of(context).pushNamed(ShortNoteEdit.routeName);

 }
}
