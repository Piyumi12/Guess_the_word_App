import 'package:flutter/material.dart';
import 'package:guess_the_word/geography/country/country_loader.dart';
import 'package:guess_the_word/geography/city/city_loader.dart';
import 'package:guess_the_word/geography/civilization/civilization_loader.dart';



class GeographyCategoryScreen extends StatefulWidget {

  static const routeName = '/geographyCategory';

  const GeographyCategoryScreen({Key key}) : super(key: key);
  @override
  _GeographyCategoryScreenState createState() => _GeographyCategoryScreenState();
}

class _GeographyCategoryScreenState extends State<GeographyCategoryScreen> {

  List images = [
    "assets/images/countries.png",
    "assets/images/cities.png",
    "assets/images/civilizations.png"

  ];

  List<String> des = [
    "A country is a distinct territorial body or political entity.\nIf You think you have learnt it.. \nJust test yourself !!",
    "Test your knowledge about the greatest cities of the world!!",
    "History teaches us fascinating things about civilizations.\nLet's see what you know!!",


  ];

  Widget customcard(String quizname,String image, String des, ){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          if(quizname == "Countries"){
            Navigator.pushNamed(context, CountryQuizLoader.routeName);
          }
          else if(quizname == "Cities"){
            Navigator.pushNamed(context, CityQuizLoader.routeName);
          }else{
            Navigator.pushNamed(context, CivilizationQuizLoader.routeName);
          }

        },

        child: Material(
          color: Colors.deepPurple,
          shadowColor: Colors.deepPurple,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(

            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 150.0,
                      width: 200.0,

                      child: Image(

                        fit:BoxFit.cover,
                        image: AssetImage(
                          image,
                        ),
                      ),

                    ),
                  ),
                ),
                Center(
                  child: Text(
                    quizname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Geography Categories",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("Countries",images[0] , des[0]),
          customcard("Cities", images[1], des[1]),
          customcard("Civilizations", images[2], des[2]),


        ],
      ),
    );
  }
}
