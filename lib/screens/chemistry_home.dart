import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_word/database/category_provider.dart';
import 'package:guess_the_word/database/db_connect.dart';
import 'package:guess_the_word/state/state_manager.dart';
import 'package:riverpod/riverpod.dart';

class ChemistryHomePage extends StatefulWidget {
  static const routeName = '/chemistry-home';
  const ChemistryHomePage({Key key,this.title}) : super(key: key);
  final String title;

  @override
  State<ChemistryHomePage> createState() => _ChemistryHomePageState();
}

class _ChemistryHomePageState extends State<ChemistryHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Chemistry"),
      ),
      body: FutureBuilder<List<Category>>(
        future: getCategories(),
        builder:(context,snapshot){
          if(snapshot.hasError)
            return Center(
              child: Text('${snapshot.error}'),
            );
          else if(snapshot.hasData){
            Category category = new Category();
            category.ID = -1;
            category.name = 'Exam';
            snapshot.data.add(category);
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: snapshot.data.map((category){
                return GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: category.ID == -1 ? Colors.green : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: AutoSizeText(
                            '${category.name}',
                            style: TextStyle(
                              color: category.ID == -1? Colors.white:Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
          else return Center(child: CircularProgressIndicator());
        } ,
      )

    );
  }

  Future <List<Category>>getCategories() async{
    var db = await copyDB();
    var result = await CategoryProvider().getCategories(db);
   // context.read(categoryListProvider).state = result;
    //context.read(categoryListProvider).state = result;
    return result;

  }



}
