// import 'package:flutter/material.dart';
//
// import 'getjson.dart';
// class ChemistryChoice extends StatefulWidget {
//   const ChemistryChoice({Key key}) : super(key: key);
//
//   @override
//   State<ChemistryChoice> createState() => _ChemistryChoiceState();
// }
//
// class _ChemistryChoiceState extends State<ChemistryChoice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: (){},
//             icon: Icon(Icons.arrow_back,color: Colors.white,)),
//         title: Text('Chemistry Quiz'),
//       ),
//       body: Scrollbar(
//         child: ListView(
//           children: [
//             Padding(padding: EdgeInsets.all(15),
//               child: const Text("Level 1"),
//             ),
//             Padding(padding: EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: 60,
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(child: InkWell(
//                         onTap: (){
//                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetJson()));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: Colors.deepPurple,
//                             border: Border.all(width: 1,color: Colors.white),
//                           ),
//                           child: Text("1"),
//                         ),
//                       ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
