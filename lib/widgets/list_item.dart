import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guess_the_word/screens/view_notes.dart';

import '../common/constant.dart';

class ListItem extends StatelessWidget {
  //const ListItem({Key key}) : super(key: key);
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String date;

  ListItem(this.id,this.title,this.content,this.imagePath,this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, ViewNotes.routeName,arguments: id);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            )
          ),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          date,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: grey2,
                          ),
                        ),
                        SizedBox(height: 8.0,),
                        Expanded(
                          child: Text(
                            content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              fontSize: 15.0,
                              color: grey2,
                            ),
                        ),
                        ),
                      ],
                    ),
                  ),
              ),
              if(imagePath!=null)
                Row(
                  children: [
                    SizedBox(width: 12.0,),
                    Container(
                      width: 80.0,
                      height: 95.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: FileImage(
                            File(imagePath),
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
