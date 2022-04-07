import 'package:flutter/material.dart';
import 'package:guess_the_word/common/constant.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key key,this.nextQuestion}) : super(key: key);
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
        child:Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: neutral,
              borderRadius: BorderRadius.circular(10.0)
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            "Next Question",
            textAlign: TextAlign.center,
          ),
        ),
    );

  }
}
