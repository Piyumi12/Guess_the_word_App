import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({Key key,this.option,this.color}) : super(key: key);

  final String option;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        child: ListTile(
          title: Text(
            option,
            style: TextStyle(
                fontSize: 22.0,
              color: color.red != color.green ? neutral:Colors.black
            ),
          ),
        ),
      );

  }
}
