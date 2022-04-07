import 'package:flutter/material.dart';

class CityResult extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  CityResult(this.resultScore, this.resetHandler);

//Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          Text(
            'Score ' '$resultScore',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),//T
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          ElevatedButton(
          style:TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: resetHandler,
              child: Text('Restart Quiz!!')),
          ElevatedButton(

          style:TextButton.styleFrom(backgroundColor: Colors.yellow),

              child: Text('Menu')),  ],),

          // ext
          //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
