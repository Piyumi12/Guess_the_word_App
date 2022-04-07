import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {

  static const routeName = '/feedback';

  const FeedbackScreen({Key key}) : super(key: key);
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>{
  TextEditingController name = TextEditingController();
  TextEditingController comment = TextEditingController();


  final firebase = FirebaseFirestore.instance;

  create()async{
    try{
      await firebase.collection("Comments").doc(name.text).set({
"name":name.text,
        "comment":comment.text
      });
    }catch(e){
      print(e);
    }
  }

  update()async{
    try{
      await firebase.collection("Comments").doc(name.text).update({'comment':comment.text});
    }catch(e){
      print(e);
    }
  }
  delete()async{
    try{
      await firebase.collection("Comments").doc(name.text).delete();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback"),
        ),
        body:Padding(
            padding: const EdgeInsets.all(20.0),
            child:Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),SizedBox(height: 15,),
                TextField(
                  controller: comment,
                  decoration: InputDecoration(
                      labelText: "Comment",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style:TextButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          create();
                          name.clear();
                          comment.clear();
                        },
                        child: Text('Create')),
                    ElevatedButton(
                        style:TextButton.styleFrom(backgroundColor: Colors.yellow),
                        onPressed: (){
                          update();
                          name.clear();
                          comment.clear();
                        },
                        child: Text('Update')),
                    ElevatedButton(
                        style:TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: (){
                          delete();
                          name.clear();
                          comment.clear();
                        },
                        child: Text('Delete')),

                  ],),
            Container(

                    height: 300,
                    width: double.infinity,
                    child:SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: firebase.collection("Comments").snapshots(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(

                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount:snapshot.data.docs.length,
                                itemBuilder: (context,i){
                                  QueryDocumentSnapshot x = snapshot.data.docs[i];
                                  return SizedBox(
                                    child: ListTile(
                                      tileColor: Colors.black12,
                                      title: Text(x['name'],style: TextStyle(
                                        fontSize: 20,

                                      ),),
                                      subtitle: Text(x['comment'],style:TextStyle(
                                        fontSize: 20,

                                      ),),
                                    ),
                                  );
                                });
                          }else{
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                )
              ],
            )
        )
    );
  }

}