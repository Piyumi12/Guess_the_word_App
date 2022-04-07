// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// class GetJson extends StatelessWidget {
//   const GetJson({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: DefaultAssetBundle.of(context).loadString("assets/quiz.json"),
//         builder: (context,snapshot){
//         List mydata = json.decode(snapshot.data.toString());
//
//         if(mydata!=null){
//           return Scaffold(
//             body: Center(
//               child: Text("Loading.."),
//             ),
//           );
//         }else{
//           return Quiz(mydata:mydata,marks:0,vie:0,level:0,uid:'');
//         }
//         });
//   }
// }
//
// class Quiz extends StatefulWidget {
//
//   final String uid;
//   var mydata;
//   int marks;
//   int vie;
//   int level;
//   const Quiz({Key key,this.mydata,this.marks,this.level,this.vie,this.uid}) : super(key: key);
//
//   @override
//   State<Quiz> createState() => _QuizState();
// }
//
// class _QuizState extends State<Quiz> {
//
//   String message = 'score'+'0'+""+"Best"+"0";
//   String levels = 'level'+'0'+'/21';
//   String vies ='5';
//
//   final String uid;
//   var mydata;
//   int marks=0;
//   int vie=5;
//   int level=0;
//
//   _QuizState(this.mydata,int marks,int level,int vie,this.uid);
//
//   Color ch = Colors.indigo;
//   Color rig = Colors.green;
//   Color wro = Colors.red;
//
//   int i = 1;
//   int timer = 30;
//   int click = 20;
//   String showTimer = '30';
//
//   Map<String,Color>btncolor = {
//     "a":Colors.indigoAccent,
//     "b":Colors.indigoAccent,
//     "c":Colors.indigoAccent,
//     "d":Colors.indigoAccent,
//   };
//
//   bool cancelTimer = false;
//   int g;
//
//   void starttimer()async{
//     const onesec = Duration(seconds: 1);
//     Timer.periodic(onesec,(Timer t){
//       setState(() {
//         if(timer<1){
//           t.cancel();
//           nextQuestion();
//         }
//         else if(cancelTimer==true){
//           t.cancel();
//         }
//         else{
//           timer = timer-1;
//         }
//         showTimer=timer.toString();
//
//       });
//     });
//   }
//
//   void nextQuestion(){
//     click-20;
//     cancelTimer=false;
//     timer=30;
//     setState(() {
//       if(i<20){
//         level++;
//         levels = 'level :'+'$level'+'/20';
//         i++;
//       }
//       else{
//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>result(marks:marks)));
//       }
//       btncolor['a']=Colors.indigoAccent;
//       btncolor['b']=Colors.indigoAccent;
//       btncolor['c']=Colors.indigoAccent;
//       btncolor['d']=Colors.indigoAccent;
//     });
//     starttimer();
//
//   }
//
//   void quit(){
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>result(marks:marks)));
//   }
//
//   void checkAnswers(String k)async{
//     if(click==20){
//       if(mydata[2][i.toString()]==mydata[1][i.toString()][k])
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//    // throw UnimplementedError();
//   }
//
//
// }
//
