import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_word/geography/loader.dart';
import 'package:guess_the_word/geography/city/city_questions.dart';

class CityQuizLoader extends StatefulWidget {

  static const routeName = '/countriesQuiz';

  CityQuizLoader({Key key}) : super(key: key);
  @override
  _CityQuizLoaderState createState() => _CityQuizLoaderState();
}

class _CityQuizLoaderState extends State<CityQuizLoader> with SingleTickerProviderStateMixin{

  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this,duration:Duration(milliseconds:2000));
    animation = Tween<double>(begin:0,end: 100).animate(progressController)..addListener(() {
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(

      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 150,
              ),

              Center(

                child: CustomPaint(
                  foregroundPainter: Loader(animation.value),
                  child:Container(
                      width: 200,
                      height:200,
                      child: GestureDetector(
                        onTap: (){
                          if(animation.value == 100){
                            progressController.reverse();

                          }else{
                            progressController.forward();
                          }
                        },
                        child:Center(
                            child: Text ("${animation.value.toInt()}%",style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                            )
                        ),
                      )),
                ),



              ), SizedBox(
                height: 150,
              ),
              OutlineButton(
                shape: StadiumBorder(),
                highlightedBorderColor: Colors.deepPurple,
                borderSide: BorderSide(
                    width: 2,
                    color: Colors.deepPurple
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CityQuestionsScreen.routeName);
                },

                child: Text('Start Quiz',style: GoogleFonts.aBeeZee(
                  color: Colors.deepPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),),
              )
            ],
          ),
        ],
      ),




    );

  }
}