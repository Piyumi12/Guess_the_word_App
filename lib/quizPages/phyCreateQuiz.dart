import 'package:guess_the_word/quizPages/quizPhysicsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/phyNoteDB.dart';
import '../widgets/widget.dart';




class PhyCreateQuiz extends StatefulWidget {
  const PhyCreateQuiz({Key key}) : super(key: key);
  @override
  _PhyCreateQuizState createState() => _PhyCreateQuizState();
}

class _PhyCreateQuizState extends State<PhyCreateQuiz> {

  final DbPhysicsNote dbnote = new DbPhysicsNote();
  final _topicController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Note note;

  List<Note> notelist;
 int updateIndex;

  @override
  Widget build(BuildContext context) {
   double width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(title: Text("Physics Notes"),),
       body: ListView(children:<Widget>[
         Form(key: _formKey,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
             children: <Widget>[
               TextFormField(
                 decoration: new InputDecoration(labelText: 'Topic'),
                 controller: _topicController,
                 validator: (val) =>
                 val.isNotEmpty? null : 'Name should not be empty',
             ),
               TextFormField(
                 decoration: new InputDecoration(labelText: 'Description'),
                 controller: _descriptionController,
                 validator: (val) =>
                 val.isNotEmpty? null : 'Name should not be empty',
               ),
               RaisedButton(
                 textColor: Colors.white,
                 color: Colors.blueAccent,
                 child: Container(
                     width: width*0.9,
                     child: Text('Submit',textAlign: TextAlign.center,)),
                 onPressed: (){
                   _submitNote(context);
                 },
               ),
               FutureBuilder(
                 future: dbnote.getNoteList(),
                 builder: (context,snapshot){
                   if(snapshot.hasData){
                     notelist = snapshot.data;
                     return ListView.builder(
                       shrinkWrap: true,
                       itemCount: notelist == null ?0 : notelist.length,
                       itemBuilder:(BuildContext context, int index){
                         Note nt = notelist[index];
                         return Card(
                           child: Row(
                               children: <Widget>[
                                  Container(
                                    width:width*0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                               Text('Topic: ${nt.topic}', style: TextStyle(fontSize: 15),),
                               Text('Description: ${nt.description}',style: TextStyle(fontSize: 15),),
                           ],
                           ),
                                  ),

                                 IconButton(onPressed: (){
                                   _topicController.text = nt.topic;
                                   _descriptionController.text = nt.description;
                                   note=nt;
                                   updateIndex = index;
                                 }, icon: Icon(Icons.edit, color: Colors.blueAccent,),),
                                 IconButton(onPressed: (){
                                   dbnote.deleteNote(nt.id);

                                   setState(() {
                                     notelist.removeAt(index);
                                   });
                                 }, icon: Icon(Icons.delete, color: Colors.red,),)
                         ],
                           ),
                         );
                       },
                     );
                   }
                   return new CircularProgressIndicator();
                 },
               )
             ],
         ),
          ),
         ),
       ]
       ),
      );


  }
void _submitNote(BuildContext context){
    if (_formKey.currentState.validate()){
      if(note==null){
        Note nt =new Note(topic:_topicController.text, description:_descriptionController.text);
        dbnote.insertNote(nt).then((id)=>{
          _topicController.clear(),
           _descriptionController.clear(),
          print('Note added to DB ${id}')

        });

      }else {
        note.topic = _topicController.text;
        note.description = _descriptionController.text;
        dbnote.updateNote(note).then((id) =>{
          setState(() {
            notelist[updateIndex].topic = _topicController.text;
        notelist[updateIndex].description = _descriptionController.text;
          }),
          _topicController.clear(),
          _descriptionController.clear(),
          note =null
        });
      }
    }
}
}
